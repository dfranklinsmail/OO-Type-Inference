Class {
	#name : #Typ,
	#superclass : #Unify,
	#category : #'OOTypeInference-Types'
}

{ #category : #comparing }
Typ >> isSameType: aToyTyp env: aMapList [
	^ self subclassResponsibility
]

{ #category : #'type unification' }
Typ >> unify: aTyp [
	self == aTyp ifTrue: [ ^ self ].
	self unifyWith: aTyp.

]

{ #category : #'type unification' }
Typ >> unify: aTyp with: unused arrow: unused2 [
	aTyp unify: aTyp link: self.

]

{ #category : #'type unification' }
Typ >> unifyWith: aTyp [
	^ self unifyFail: aTyp
]
