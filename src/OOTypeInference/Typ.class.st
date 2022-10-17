Class {
	#name : #Typ,
	#superclass : #Unify,
	#category : #'OOTypeInference-Types'
}

{ #category : #'type unification' }
Typ >> inspectionAST [

	<inspectorPresentationOrder: 35 title: 'AST'>
	^ SpTreePresenter new
		  roots: { self ast };
		  children: [ :aNode | aNode children ];
		  display: [ :each | 
			  String streamContents: [ :stream | 
					  stream
						  nextPutAll: each class name;
						  nextPut: $(;
						  nextPutAll: ((each formattedCode truncateTo: 50)
								   copyReplaceAll: String cr
								   with: String space);
						  nextPut: $) ] ];
		  yourself

]

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
	self = aTyp ifTrue: [ ^true. ].
	aTyp isTCls ifTrue: [  
		"does this work? what if methods aren't in the same order, what is order, 
		should methods be sorted by selector"
		self methods with: aTyp methods do: [ :mthdA :mthdB | mthdA unifyWith: mthdB ].
		self variables with: aTyp variables do:  [ :vrA :vrB | vrA unifyWith: vrB ].
		^true.
	].
	^ self unifyFail: aTyp
]
