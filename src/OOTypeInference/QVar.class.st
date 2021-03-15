Class {
	#name : #QVar,
	#superclass : #Typ,
	#instVars : [
		'qname'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #accessing }
QVar class >> name: aName [
	^self new name: aName
]

{ #category : #accessing }
QVar >> qname: aQName [
	qname := aQName.
	
]
