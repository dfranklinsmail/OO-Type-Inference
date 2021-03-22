Class {
	#name : #QVar,
	#superclass : #Typ,
	#instVars : [
		'qname'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #accessing }
QVar class >> qname: aQName [
	^self new qname: aQName
]

{ #category : #accessing }
QVar >> isQVar [
	^ true.
	
]

{ #category : #accessing }
QVar >> qname [
	^qname.
]

{ #category : #accessing }
QVar >> qname: aQName [
	qname := aQName.
	
]
