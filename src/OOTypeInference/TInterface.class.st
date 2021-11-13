Class {
	#name : #TInterface,
	#superclass : #Typ,
	#instVars : [
		'selectors'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'as yet unclassified' }
TInterface >> addSelector: aSelector [
	selectors add: aSelector.
]

{ #category : #'as yet unclassified' }
TInterface >> initialize [ 
	selectors := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TInterface >> isSameType: aToyTyp env: scratchPad [
aToyTyp isTInterface ifFalse: [ "return error, can only compare to another TInterface" ^false. ].
"Does the given TInterface have all the selectors that I have"
selectors do: [ :selector | 
						(aToyTyp selectors indexOf: selector) = 0 ifTrue: [^false.]
					].
^true.


]

{ #category : #'as yet unclassified' }
TInterface >> isTInterface [
	^ true.
]

{ #category : #'as yet unclassified' }
TInterface >> selectors [
	^ selectors.
]

{ #category : #'as yet unclassified' }
TInterface >> unify: aTyp [
	aTyp isTInterface ifFalse: [	"can only unify with another TInterface."
											^ self unifyFail: aTyp. ].
	"add all the selectors that are not in common"
	selectors do: [ :selector | aTyp selectors indexOf: selector ifAbsent: [aTyp addSelector: selector]].
	aTyp unify: self.
]
