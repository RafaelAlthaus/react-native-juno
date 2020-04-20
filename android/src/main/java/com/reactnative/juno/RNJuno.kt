package com.reactnative.juno

import br.com.juno.directcheckout.DirectCheckout
import br.com.juno.directcheckout.model.Card
import br.com.juno.directcheckout.model.DirectCheckoutException
import br.com.juno.directcheckout.model.DirectCheckoutListener
import com.facebook.react.bridge.Callback
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class RNJuno(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNJuno"
    }

    @ReactMethod
    fun initialize (publicToken: String, production: Boolean) {
        try {
            DirectCheckout.initialize(reactContext, production)
        } catch(ex: Exception) {
            println(ex.toString())
        }
    }

    @ReactMethod
    fun getCardHash (cardNumber: String, holderName: String, securityCode: String, expirationMonth: String, expirationYear: String, callback: Callback) {
        val card = Card(cardNumber, holderName, securityCode, expirationMonth, expirationYear)

        DirectCheckout.getCardHash(card, object : DirectCheckoutListener<String> {
            override fun onSuccess(cardHash: String) {
                callback.invoke(null, cardHash)
            }

            override fun onFailure(ex: DirectCheckoutException) {
                callback.invoke(ex.toString(), null)
            }
        })
    }

    @ReactMethod
    fun isValidCardNumber (cardNumber: String, callback: Callback) {
        try {
            callback.invoke(DirectCheckout.isValidCardNumber(cardNumber))
        } catch(ex: Exception) {
            println(ex.localizedMessage)
        }
    }

    @ReactMethod
    fun isValidExpireDate (month: String, year: String, callback: Callback) {
        try {
            callback.invoke(DirectCheckout.isValidExpireDate(month, year))
        } catch(ex: Exception) {
            println(ex.localizedMessage)
        }
    }

    @ReactMethod
    fun isValidSecurityCode (code: String, cardNumber: String, callback: Callback) {
        try {
            callback.invoke(DirectCheckout.isValidSecurityCode(cardNumber, code))
        } catch(ex: Exception) {
            println(ex.localizedMessage)
        }
    }
}
