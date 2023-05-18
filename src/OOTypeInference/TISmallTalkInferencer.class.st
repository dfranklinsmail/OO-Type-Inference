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
	currentClass := TCls class: aClass
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

{ #category : #accessing }
TISmallTalkInferencer >> visit: anRBNode [

	^ anRBNode acceptVisitor: self
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
