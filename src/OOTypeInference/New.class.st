Class {
	#name : #New,
	#superclass : #Exp,
	#instVars : [
		'class'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'instance creation' }
New class >> class: aCls [
	"comment stating purpose of class-side method"
	"scope: class-variables  &  class-instance-variables"	
	^Obj instantiate: aCls.
]
