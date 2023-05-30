Class {
	#name : #TCls,
	#superclass : #Typ,
	#instVars : [
		'iMethods',
		'cMethods',
		'className',
		'variables'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TCls class >> class: aClassName [
	^self new class: aClassName.
]

{ #category : #'as yet unclassified' }
TCls >> addClsMethod: aTMthd [

	cMethods
		at: aTMthd selector
		ifPresent: [ :currentTMthd | currentTMthd unifyWith: aTMthd ]
		ifAbsentPut: [ aTMthd ].
	aTMthd parentTCls: self
]

{ #category : #'as yet unclassified' }
TCls >> addInstMethod: aTMthd [

	iMethods
		at: aTMthd selector
		ifPresent: [ :currentTMthd | currentTMthd unifyWith: aTMthd ]
		ifAbsentPut: [ aTMthd ].
	aTMthd parentTCls: self
]

{ #category : #'as yet unclassified' }
TCls >> addTypMap: aTyp to: aMap [
	aTyp isClass 
		ifTrue: [ aMap at: aTyp ifPresent: [:aCls | ^ self unifyWith: aCls ] ifAbsentPut: [ aTyp ]].
	^true
]

{ #category : #'as yet unclassified' }
TCls >> addVariable: aTVar [
	variables add: aTVar.
]

{ #category : #'as yet unclassified' }
TCls >> class: aClassName [
	className := aClassName
]

{ #category : #'as yet unclassified' }
TCls >> classMethods [

	^ cMethods
]

{ #category : #'as yet unclassified' }
TCls >> clsName [
	^ className
]

{ #category : #equality }
TCls >> equals: aType [

	aType isTCls ifFalse: [ ^ false ].
	^ className name == aType clsName name
]

{ #category : #'as yet unclassified' }
TCls >> hasClsMethod: aTMthd [
	"loop through methods to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"

	"methods do: [ :myMthd | self halt. (myMthd isSameType: aTMthd) ifTrue: [^true.]]."

	"loop through methods to see if any of them matches the given methods slector"

	cMethods do: [ :myMthd |
		myMthd selector == aTMthd selector ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'as yet unclassified' }
TCls >> hasClsMethod: aTMthd env: anEnv [
	"loop through methods to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"

	cMethods do: [ :myMthd |
		(myMthd isSameType: aTMthd env: anEnv) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
TCls >> hasInstMethod: aTMthd [
	"loop through methods to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"

	"methods do: [ :myMthd | self halt. (myMthd isSameType: aTMthd) ifTrue: [^true.]]."

	"loop through methods to see if any of them matches the given methods slector"

	iMethods do: [ :myMthd |
		myMthd selector == aTMthd selector ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'as yet unclassified' }
TCls >> hasInstMethod: aTMthd env: anEnv [
	"loop through methods to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"

	iMethods do: [ :myMthd |
		(myMthd isSameType: aTMthd env: anEnv) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
TCls >> hasVariable: aTVar env: anEnv [
	"loop through varialbes to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"
	variables do: [ :myTVar | (myTVar isSameType: aTVar env: anEnv) ifTrue: [^true.]].
	^false
]

{ #category : #'as yet unclassified' }
TCls >> initialize [

	cMethods := Dictionary new.
	iMethods := Dictionary new.
	variables := OrderedCollection new
]

{ #category : #'as yet unclassified' }
TCls >> instanceMethods [

	^ iMethods
]

{ #category : #comparing }
TCls >> isSameMethods: aTCls [

	| hasAllClsMethods hasAllInstMethods |
	
	hasAllClsMethods := true.
	cMethods do: [ :aMthd |
		hasAllClsMethods := hasAllClsMethods & (aTCls hasClsMethod: aMthd) ].
	
	hasAllInstMethods := true.
	iMethods do: [ :aMthd |
		hasAllInstMethods := hasAllInstMethods & (aTCls hasInstMethod: aMthd) ].

	^ hasAllClsMethods & hasAllInstMethods
]

{ #category : #'as yet unclassified' }
TCls >> isSameMethods: aTType env: anEnv [

	| hasAllMethods |
	hasAllMethods := true.
	cMethods do: [ :aMthd |
		hasAllMethods := hasAllMethods
		                 & (aTType hasClsMethod: aMthd env: anEnv) ].
	
	iMethods do: [ :aMthd |
		hasAllMethods := hasAllMethods
		                 & (aTType hasInstMethod: aMthd env: anEnv) ].

	^ hasAllMethods
]

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTTyp [

	aTTyp isTCls ifFalse: [ ^ false ].
	self = aTTyp ifTrue: [ ^ true ].
	"need to check selectors"

	^ (self clsName = aTTyp clsName and:
		   (self isSameMethods: aTTyp)) and:
		  (self isSameVariables: aTTyp)
]

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTTyp env: anEnv [
	aTTyp isTCls ifFalse: [^ false]. 
	(self = aTTyp) ifTrue: [ ^ true ].
	"need to check selectors".
	
	^((self clsName = aTTyp clsName) and: 
		(self isSameMethods: aTTyp env: anEnv)) 
		and: (self isSameVariables: aTTyp env: anEnv).

]

{ #category : #'as yet unclassified' }
TCls >> isSameVariables: aTType [

	| isSame |
	isSame := true.
	variables do: [ :aVar | 
		isSame := isSame & (aTType hasVariable: aVar) ].

	^ isSame
]

{ #category : #'as yet unclassified' }
TCls >> isSameVariables: aTType env: anEnv [
	| isSame |
	isSame := true.
	variables do: [:aVar | 	
			isSame := isSame & (aTType hasVariable: aVar env: anEnv)].
	
	^isSame.
]

{ #category : #'as yet unclassified' }
TCls >> isTCls [
	^ true.
]

{ #category : #'as yet unclassified' }
TCls >> variables [
	^variables
]
