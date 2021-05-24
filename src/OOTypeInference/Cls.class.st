Class {
	#name : #Cls,
	#superclass : #Exp,
	#instVars : [
		'methods',
		'variables',
		'selector'
	],
	#classInstVars : [
		'methods'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #accessing }
Cls >> addMethod: method [
	methods = nil ifTrue: [ methods := OrderedCollection new. ]. "probably don't need this as it in initiazlie"
	methods add: method.
]

{ #category : #'class initialization' }
Cls >> initialize [ 
	super initialize.
	methods := OrderedCollection new.
]

{ #category : #accessing }
Cls >> methods [
	^methods sort: [ :first :second | first selector <= second selector].
]

{ #category : #accessing }
Cls >> methods: myMethods [.
	methods := myMethods.
]

{ #category : #accessing }
Cls >> typeOf: environment [
	^ TCls new.
]
