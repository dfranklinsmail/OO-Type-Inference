Class {
	#name : #TISmallTalkInferencer,
	#superclass : #Object,
	#instVars : [
		'currentClass',
		'instanceVariables',
		'enviroment'
	],
	#category : #'OOTypeInference-Typer'
}

{ #category : #accessing }
TISmallTalkInferencer >> currentClass: aClass [

	currentClass := enviroment
		                at: aClass
		                ifAbsentPut: [ TCls class: aClass ].
]

{ #category : #accessing }
TISmallTalkInferencer >> findClass: aClass withSelector: aSelector [
	"spectial case for when selector is 'new'"

	aSelector == #new ifTrue: [ ^ aClass ].

	"otherwise look up selector in the classes compiled methods"
	aClass
		compiledMethodAt: aSelector
		ifPresent: [ ^ aClass ]
		ifAbsent: [ "check if the slector is a class side method, should it just return aClass?"
			aClass classSide
				compiledMethodAt: aSelector
				ifPresent: [ ^ aClass classSide ]
				ifAbsent: [
					aClass isBehavior
						ifTrue: [ self halt ]
						ifFalse: [
						^ self findClass: aClass superclass withSelector: aSelector ] ] ]
]

{ #category : #accessing }
TISmallTalkInferencer >> initialize [

	enviroment := Dictionary new
]

{ #category : #transform }
TISmallTalkInferencer >> typeMethod: aCompiledMethod [
	"Recursively traverse the given method and all methods contained 
until the classes and methods found are typed."

	| inferedType |
	^ enviroment
		  at: aCompiledMethod
		  ifPresent: [ :methodType "if the method has already been typed do we need to type again? Have things changed, class instance variables? " |
			  ^ methodType ]
		  ifAbsentPut: [ "contains needs to be interesting, ""If you run a smalltalk program and 'save exit the ide/vm,
would you resume execution from where you left off?. Can you
fully restore an iimage "
			  Transcript
				  show: 'typing method ';
				  show: aCompiledMethod;
				  cr.
			  inferedType := self visit: aCompiledMethod ast.
			  enviroment at: aCompiledMethod put: inferedType.
			  ^ inferedType ]
]

{ #category : #transform }
TISmallTalkInferencer >> typeMethod: aCompiledMethod inClass: aClass [
	^ self
		  typeMethod: aCompiledMethod
		  with: OrderedCollection new
		  inClass: aClass
]

{ #category : #accessing }
TISmallTalkInferencer >> typeMethod: aCompiledMethod with: arguments [
	"Recursively traverse the given method and all methods contained 
until the classes and methods found are typed."

	| oldInstanceVariables methodType |
	oldInstanceVariables := instanceVariables.
	instanceVariables := Dictionary new.
	instanceVariables
		at: #self
		put: (TCls class: aCompiledMethod realClass).
	arguments
		with: aCompiledMethod argumentNames
		do: [ :type :name | instanceVariables at: name put: type ].

	methodType := self typeMethod: aCompiledMethod.

	instanceVariables := oldInstanceVariables.
	^ methodType
]

{ #category : #transform }
TISmallTalkInferencer >> typeMethod: aMethodName with: args inClass: aClass [
	"Recursively traverse the given method and all methods contained 
until the classes and methods found are typed."

	| mthdTyp |
	currentClass := enviroment
		                at: aClass
		                ifAbsentPut: [ TCls class: aClass ].

	mthdTyp := currentClass methods
		           at: aMethodName
		           ifPresent: [ :mTyp "if the method has already been typed do we need to type again? Have things changed, class instance variables? " |
			           ^ mTyp "if we type again should we unify?" ]
		           ifAbsentPut: [
			           | pTyp |
			           "type the method"
			           pTyp := self
				                   typeMethod:
					                   (aClass
						                    compiledMethodAt: aMethodName
						                    ifAbsent: [
							                    aClass class
								                    compiledMethodAt: aMethodName
								                    ifAbsent: [ "special case when selector is new""throw an exception or look for parent implementations?"
									                    aMethodName == #new ifTrue: [
										                    | method |
										                    method := TMthd
											                              selector: #new
											                              result:
											                              (TObj from:
												                               (TCls class: aClass)).
										                    currentClass addMethod: method.
										                    method ] ] ])
				                   with: args.
			           ^ pTyp ].
	^ mthdTyp
]

{ #category : #accessing }
TISmallTalkInferencer >> visit: anRBNode [

	^ anRBNode acceptVisitor: self
]

{ #category : #accessing }
TISmallTalkInferencer >> visitGlobalVariableNode: aGlobalVariableNode [

	^ TCls class: aGlobalVariableNode variable value
]

{ #category : #accessing }
TISmallTalkInferencer >> visitLiteralValueNode: anRBLiteralValueNode [
	"visiting a value node, should result in a TCls of what ever type the value is"

	^ TCls class: anRBLiteralValueNode value class
]

{ #category : #accessing }
TISmallTalkInferencer >> visitMessageNode: anRBMessageNode [
	"visiting a message translates into visiting the selector node"

	| selector receiver tClsOfReceiver methodType savedCurrentClass |
	selector := anRBMessageNode selectorAndArgumentNames.
	receiver := anRBMessageNode receiver.
	tClsOfReceiver := self visit: receiver. "I should know what the type of this is or I can compute it"
	"we need to visit the method"
	"need a way to get the rbMethodNode of the selector from the class of the receiver"
	savedCurrentClass := currentClass.

	currentClass := self
		                findClass: tClsOfReceiver clsName
		                withSelector: selector asSymbol.
	methodType := self
		              typeMethod: selector asSymbol
		              inClass: currentClass.

	"unwrap the return type of the method before returning, should it be wraped in a TObj to begin with?"
	currentClass := savedCurrentClass.
	^ methodType returnType tv
	"^ self visit: anRBMessageNode selectorNode"
]

{ #category : #accessing }
TISmallTalkInferencer >> visitMethodNode: anRBMethodNode [

	| args constraints |
	args := anRBMethodNode allArgumentVariables collect: [ :arg | 
		        instanceVariables at: arg "look at instanceVariables to get arg type""visit: arg" ].
	constraints := anRBMethodNode statements collect: [ :statement | 
		               self visit: statement ].

	^ TMthd
		  selector: anRBMethodNode selector
		  arguments: args
		  result: (constraints at: 1)
]

{ #category : #accessing }
TISmallTalkInferencer >> visitReturnNode: anRBReturnNode [
	"visiting a return node in a method, a method may have multiple return nodes or none"

	| return |
	anRBReturnNode value.
	return := TObj new.
	return tv: (self visit: anRBReturnNode value).
	^ return
]
