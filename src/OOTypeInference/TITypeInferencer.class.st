"
The type inference is responsible for typing methods and classes. It does this by walking the abstract syntax tree of a method and derive the type of the method.
"
Class {
	#name : #TITypeInferencer,
	#superclass : #Object,
	#instVars : [
		'enviroment',
		'currentClass'
	],
	#category : #'OOTypeInference-Typer'
}

{ #category : #accessing }
TITypeInferencer >> currentClass: aTCls [

	^ currentClass := aTCls.
]

{ #category : #accessing }
TITypeInferencer >> getTCls: classType [
enviroment at: classType ifAbsentPut: [ TCls class: classType ]. 
^enviroment at: classType.
]

{ #category : #initialization }
TITypeInferencer >> initialize [

	enviroment := Dictionary new
]

{ #category : #transform }
TITypeInferencer >> typeMethod: aCompiledMethod [


	"Recursively traverse the given method and all methods contained 
until the classes and methods found are typed."

	| inferedType |
	^ enviroment
		  at: aCompiledMethod
		  ifAbsentPut: [ "contains needs to be interesting, ""If you run a smalltalk program and 'save exit the ide/vm,
would you resume execution from where you left off?. Can you
fully restore an iimage "
			  inferedType := self visit: aCompiledMethod ast.
			  enviroment at: aCompiledMethod put: inferedType.
			  ^ inferedType ]
]

{ #category : #visiting }
TITypeInferencer >> visit: anRBNode [
^ anRBNode acceptVisitor: self.

]

{ #category : #visiting }
TITypeInferencer >> visitCompiledMethod: aSCompiledNode [


]

{ #category : #visiting }
TITypeInferencer >> visitLiteralValueNode: anRBLiteralValueNode [

	"visiting a value node, should result in a TCls of what ever type the value is"
	^TCls class: (anRBLiteralValueNode value class).
]

{ #category : #visiting }
TITypeInferencer >> visitMessageNode: anRBMessageNode [

	"visiting a message translates into visiting the selector node"

	| selector receiver tClsOfReceiver methodType |
	selector := anRBMessageNode selectorAndArgumentNames.
	receiver := anRBMessageNode receiver.
	tClsOfReceiver := self visit: receiver. "I should know what the type of this is or I can compute it"
	"we need to visit the method"
	"need a way to get the rbMethodNode of the selector from the class of the receiver"
	methodType := self typeMethod:
		              tClsOfReceiver clsName >> selector asSymbol.
	"unwrap the return type of the method before returning, should it be wraped in a TObj to begin with?"
	^ methodType returnType tv
	"^ self visit: anRBMessageNode selectorNode"
]

{ #category : #visiting }
TITypeInferencer >> visitMethodNode: anRBMethodNode [

	| args constraints |
	args := OrderedCollection new.
	args add: (TCls class: Int).
	constraints := anRBMethodNode statements collect: [ :statement | 
		               self visit: statement ].

	^ TMthd selector: anRBMethodNode selector type: args arrow: (constraints at: 1)
]

{ #category : #visiting }
TITypeInferencer >> visitReturnNode: anRBReturnNode [
	"visiting a return node in a method, a method may have multiple return nodes or none"
	| return |
	anRBReturnNode value.
	return := TObj new.
	return tv: (self visit: anRBReturnNode value).
	^return.
	
]

{ #category : #visiting }
TITypeInferencer >> visitSelectorNode: anRBSelectorNode [

	"visiting a selector node translate into visiting the method node, it has"
^ self visitSelectorNode: anRBSelectorNode methodNode.
]

{ #category : #visiting }
TITypeInferencer >> visitSelfNode: aSelfNode [

	"visiting a selector node translate into visiting the method node, it has"

	^ currentClass.
]
