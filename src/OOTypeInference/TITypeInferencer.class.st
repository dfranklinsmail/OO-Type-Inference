Class {
	#name : #TITypeInferencer,
	#superclass : #Object,
	#instVars : [
		'inferedType',
		'enviroment'
	],
	#category : #'OOTypeInference-Typer'
}

{ #category : #initialization }
TITypeInferencer >> initialize [

	enviroment := Dictionary new
]

{ #category : #'as yet unclassified' }
TITypeInferencer >> typeMethod: aCompiledMethod [

	"Recursively traverse the given method and all methods contained 
until the classes and methods found are typed."

	(enviroment contains: aCompiledMethod)
		ifTrue: [ ^ enviroment at: aCompiledMethod ]
		ifFalse: [ 
			inferedType := self visit: aCompiledMethod ast.
			enviroment at: aCompiledMethod put: inferedType.
			^inferedType. ]
	"contains needs to be interesting, "

	"If you run a smalltalk program and 'save exit the ide/vm,
would you resume execution from where you left off?. Can you
fully restore an iimage "
]

{ #category : #'as yet unclassified' }
TITypeInferencer >> visit: anRBNode [
^ anRBNode acceptVisitor: self.

]

{ #category : #'as yet unclassified' }
TITypeInferencer >> visitLiteralValueNode: anRBLiteralValueNode [

	"visiting a value node, should result in a TCls of what ever type the value is"
	^TCls class: (anRBLiteralValueNode value class).
]

{ #category : #'as yet unclassified' }
TITypeInferencer >> visitMessageNode: anRBMessageNode [

	"visiting a message is simply visiting the method node, it has"
	self halt.
^ self visitMethodNode: anRBMessageNode
]

{ #category : #'as yet unclassified' }
TITypeInferencer >> visitMethodNode: anRBMethodNode [

	| args constraints |
	args := OrderedCollection new.
	args add: (TCls class: Int).
	constraints := anRBMethodNode statements collect: [ :statement | 
		               self visit: statement ].

	^ TMthd selector: anRBMethodNode selector type: args arrow: (constraints at: 1)
]

{ #category : #'as yet unclassified' }
TITypeInferencer >> visitReturnNode: anRBReturnNode [
	"visiting a return node in a method, a method may have multiple return nodes or none"
	| return |
	anRBReturnNode value.
	return := TObj new.
	return tv: (self visit: anRBReturnNode value).
	^return.
	
]
