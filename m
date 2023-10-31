Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE81F945
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+tNfEvz"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77784edc2edso392317485a.1
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778085; x=1699382885; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXVowolFU2g+s91gNdM54EsdOkLlJgHR7YHOdFGNnM8=;
        b=a+tNfEvzYUeT7T/BWfqLkbhSUYfffR11ZNPr0jkDY2y/bNMngrpH5QdrLou3ecQMiX
         L8/ZcXq5ye6xbpK2hPFI6zZnRLNkfx9rFLLJm16jr0P+nZGANCWljQ2OCKnMnd9NN82B
         66tDC3KYe/5qjLR0N2+CS1eAYEbBtVmdTTgV6OUsfLuCotEDhV9Z1XztFjphS7TdvjE9
         dkN7Y9kufEP39458QozHL2b9xC7diUE91+VUv5JoYO1H2O3znE4RsJStNZd8o65H7dWl
         1rx/4C0jXd1o4Jza5uSVgtC3ZIMDUwV21d7GfQdyfiUg9y+VjHpSlbh7s5mynX3e6a+A
         id0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778085; x=1699382885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXVowolFU2g+s91gNdM54EsdOkLlJgHR7YHOdFGNnM8=;
        b=OyAORWjMXMF9pyjx+f8eB3UsrPwvoUJnf9wUGIzGMhu0yYXpYGD1YfYM14hn/q91kH
         IpytJF6xl6fLUDv49L0kuldN8aaAJjZqeWMXPSVsu/kaOeZbmtXiJVMc1ecI+CbZak3G
         J2PSi0kqm3lsPggv6QjPNl3Gb+QXvo3vHT1IxJzwVucL2PsXaApeUJpTAoV6HDDgIPYg
         Sy3jffoEONZpU6MJJ7Qwaezu9Ca0AnwCyespEThpbrzrEa8Wb5VIAv+X/WTWB4XHYkAx
         SDL7GtaR8uZx9dvNs+a9WVTtXeTKJny3aQ6T6z8lAs4U1ZbPhGI2qmYJrS/JUXMLukFP
         ngfQ==
X-Gm-Message-State: AOJu0YzmfZIJ8iBPrKRMgpqTZ0imyEwjltWX7oNoF+XDyUtPQ4qo33VK
	Yi8kCFwLm0PsnByTBKjSoQ7n+kETKw8=
X-Google-Smtp-Source: AGHT+IE7RLrPQq2fHBj8+rU4Jqp+vs+OMX+PfqhoVTzxeLQ93iHjcoTbDncG7SnoKaiLrFzNKkNbIg==
X-Received: by 2002:a05:620a:404e:b0:774:35da:75ac with SMTP id i14-20020a05620a404e00b0077435da75acmr15528162qko.55.1698778085352;
        Tue, 31 Oct 2023 11:48:05 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/9] doc: PKEX support for DPP
Date: Tue, 31 Oct 2023 11:47:47 -0700
Message-Id: <20231031184750.722404-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PKEX is part of the WFA EasyConnect specification and is
an additional boostrapping method (like QR codes) for
exchanging public keys between a configurator and enrollee.

PKEX operates over wifi and requires a key/code be exchanged
prior to the protocol. The key is used to encrypt the exchange
of the boostrapping information, then DPP authentication is
started immediately aftewards.

This can be useful for devices which don't have the ability to
scan a QR code, or even as a more convenient way to share
wireless credentials if the PSK is very secure (i.e. not a
human readable string).

PKEX would be used via the three DBus APIs on a new interface
SharedCodeDeviceProvisioning.

ConfigureEnrollee(a{sv}) will start a configurator with a
static shared code (optionally identifier) passed in as the
argument to this method.

StartEnrollee(a{sv}) will start a PKEX enrollee using a static
shared code (optionally identifier) passed as the argument to
the method.

StartConfigurator() will start a PKEX configurator (should be
already registered) which will query an agent for an enrollees
shared code. Enrollees are distinguished by the identifier.

After the PKEX protocol is finished, DPP bootstrapping keys have
been exchanged and DPP Authentication will start, followed by
configuration.
---
 doc/device-provisioning-api.txt | 149 ++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index ac204f46..3c6fc74e 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -71,3 +71,152 @@ Properties	boolean Started [readonly]
 
 			Indicates the DPP URI. This property is only available
 			when Started is true.
+
+
+Interface	net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+		ConfigureEnrollee(a{sv})
+
+			Starts a DPP configurator using a shared code (and
+			optionally identifier) set in the dictionary argument.
+			Valid dictionary keys are:
+
+			string Code
+				The shared code to use. The code used by both
+				parties (configurator and enrollee) must match.
+
+			string Identifier
+				An optional identifier. The identifier used by
+				both parties must match. Per the DPP spec the
+				identifier "shall be a UTF-8 string not greater
+				than eighty (80) octets"
+
+			As with the DeviceProvisioning interface, configurators
+			must be connected to the network they wish to configure
+			in order to start.
+
+			Once started a configurator (acting as a responder) will
+			listen on the currently connected channel for an
+			enrollee's initial exchange request which will kick off
+			the shared code bootstrapping protocol (PKEX). Once
+			completed DPP will start automatically. Only one
+			enrollee can be configured per call to
+			ConfigureEnrollee, i.e. once PKEX/DPP is has finished
+			(including failure) the configurator will stop.
+
+			The SharedCode methods have an eventual timeout and will
+			stop automatically after 2 minutes.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.InvalidArguments
+
+		StartEnrollee(a{sv})
+
+			Starts a DPP enrollee using a shared code (and
+			optionally identifier) set in the dictionary argument
+			(described above in ConfigureEnrollee).
+
+			As with the device provisioning interface, enrollees
+			must be disconnected in order to start.
+
+			Once started an enrollee (acting as an initiator) will
+			iterate channels sending out broadcast exchange requests
+			waiting for a response from a configurator. A response
+			will kick off the shared code bootstrapping protocol
+			(PKEX), followed by DPP if successful. Once the
+			protocols have completed, or failed, the enrollee will
+			stop. If failed, StartEnrollee will need to be called
+			again to retry.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.InvalidArguments
+
+		StartConfigurator()
+
+			Start a shared code configurator using an agent to
+			obtain the shared code. This method is meant for an
+			automated use case where a configurator is capable of
+			configuring multiple enrollees, and distinguishing
+			between them by their identifier.
+
+			Prior to calling, a SharedCodeAgent must be registered
+			using RegisterSharedCodeAgent. Only a single agent can
+			be registered per SharedCodeInterface.
+
+			This method behaves nearly the same as ConfigureEnrollee
+			except upon receiving an enrollees first exchange
+			request the registered agent will be asked for the
+			shared code using the RequestSharedCode method.
+
+			Though the agent can provide shared codes for multiple
+			enrollees, this method will only configure a single
+			enrollee at a time. Once completed it will need to be
+			called again to configure additional enrollees.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.iwd.NoAgent
+
+		void RegisterSharedCodeAgent(object path)
+
+			Register the agent object for servicing shared code
+			requests on the net.connman.iwd.SharedCodeAgent
+			interface. There may only be one agent registered at a
+			time per SharedCodeDeviceProvisioning interface.
+
+			Possible Errors:	[service].Error.InvalidArguments
+						[service].Error.AlreadyExists
+
+		void UnregisterSharedCodeAgent()
+
+			Unregister an existing agent.
+
+			Possible Errors:	[service].Error.NotFound
+
+Properties	boolean Started [readonly]
+
+			True if shared code device provisioning is currently
+			active. (configurator or enrollee is started)
+
+		string Role [readonly, optional]
+
+			Indicates the DPP role. Possible values are "enrollee"
+			or "configurator". This property is only available when
+			Started is true.
+
+SharedCodeAgent hierarchy
+=========================
+
+Service		unique name
+Interface	net.connman.iwd.SharedCodeAgent [Experimental]
+Object path	freely definable
+
+Methods		void Release() [noreply]
+
+			This method gets called when the service daemon
+			unregisters the agent.
+
+		string RequestSharedCode(object network, string identifier)
+
+			This method gets called when a shared code is requested
+			for a particular enrollee, distingushed by the
+			identifier. The shared code agent should lookup the
+			identifier and return the shared code, or return an
+			error if not found.
+
+			Possible Errors:	[service].Error.Canceled
+						[service].Error.NotFound
+
+		void Cancel(string reason) [noreply]
+
+			This method gets called to indicate that the agent
+			request failed before a reply was returned. The
+			argument will indicate why the request is being
+			cancelled and may be "user-canceled", "timed-out" or
+			"shutdown".
+
+Examples	Requesting a shared code for an enrollee identified by "foo"
+
+			RequestSharedCode("foo") ==> "super_secret_code"
-- 
2.25.1

