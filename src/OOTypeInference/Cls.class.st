Class {
	#name : #Cls,
	#superclass : #Object,
	#instVars : [
		'methods',
		'variables',
		'selector'
	],
	#classInstVars : [
		'methods'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #accessing }
Cls >> addMethod: method [
	methods add: method.
]

{ #category : #accessing }
Cls >> addVariable: aVariable [
	variables add: aVariable.
]

{ #category : #accessing }
Cls >> initialize [
	variables := OrderedCollection new.
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
	| aTCls |
	aTCls:= TCls class: (Int class).
	"should I do the variables typing first? typing of the methods will change variable types"
	variables do: [ :vr | aTCls addVariable: "need to wrap in a type with both name and type"(vr typeOf: environment). ].
	methods do: [ :mthd | aTCls addMethod: (mthd typeOf: environment). ].
	^ aTCls.
]
