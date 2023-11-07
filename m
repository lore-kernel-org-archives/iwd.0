Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54675328BA
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIbk1wwr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5b499b18b28so71102607b3.0
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 09:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699376795; x=1699981595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/Ue//ra30Xf4mmQMUmcTDf1FcjxaVfrWVWi9bOpgnI=;
        b=EIbk1wwr+LK3JIGwBXJTJ+U0nKmKGmMvneiWqL0d8GVmlz5gj91mmKZk3COqeNdrnu
         BQU39uF17siPrx/hNlpXIDG0yohceah0Wan7cbnMwyaGf4w58UMAchBPq6tYPH1c2Mma
         d6Yb5tY+qtkpm9Pz/PAtcBdRsavhNlgfgMZmImWaTUmmlYA8PyIj+HItKLi8Aek0eIpg
         KcK+Qvoqnve/2jZj6FMo0SkyUgtfokOxAUc6gP7y0rMj53v+PAq+r5ugDHkZtePRzwhV
         2Bvd/+JgcNvmZLL1xp+afbIHN3rp3/FOa5GdljRVqGcg43GZnE35+DwcKLMKkfRKNrlD
         G2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376795; x=1699981595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/Ue//ra30Xf4mmQMUmcTDf1FcjxaVfrWVWi9bOpgnI=;
        b=w7U7Xb2LGDPwBQBTQ8LZ7MdOmEG1h72m99AwpaV8xSVJWGDKqIzKqYM314GlHYboBX
         qYMa/Oo7aqTYbjz4VEuo4BNLWMXnYipoS5dnGCprjiauKpWzZv0SxWptMmKBpmloE26W
         U/I226mNhbONiQdwSP1KMUf1vnxFbWGtDXZAKyoYp6X3liffVRukn/CoKAiBE1GjZkuq
         jiJJqCt14QSBD4WCdKPo+ben90k7BJqhPhPtVeS9XLcE17kVXgGloK/o1cI3A1wdtCdO
         cIBdf89eBf2E9veD+37UtTOrEq8rJ46Hp/zo2f7HzXl+2/EFuFdGnD9ypUt+2DC5OX94
         jk1A==
X-Gm-Message-State: AOJu0YxUZxJbIdlHpF/JmCA5Ag8EqlZTY2bxgCS8FA0LGH+HfqdmXMuv
	LTpnsDfSYxKyiCcpLCg344aYm/Xj33k=
X-Google-Smtp-Source: AGHT+IEh05LyokTVtCON+pWzfB4tVvRiGOIJUhgCJbJAhWJWM7g4uLC8ucmdT7Ghys1bXcML2u22tQ==
X-Received: by 2002:a0d:ebc5:0:b0:5a7:aa54:42b1 with SMTP id u188-20020a0debc5000000b005a7aa5442b1mr14052238ywe.28.1699376794925;
        Tue, 07 Nov 2023 09:06:34 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z127-20020a814c85000000b005a7db2a0dddsm5790475ywa.3.2023.11.07.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:06:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/4] doc: PKEX support for DPP
Date: Tue,  7 Nov 2023 09:06:26 -0800
Message-Id: <20231107170629.1831655-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107170629.1831655-1-prestwoj@gmail.com>
References: <20231107170629.1831655-1-prestwoj@gmail.com>
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

StartConfigurator(o) will start a PKEX configurator and use the
agent specified by the path argument. The configurator will query
the agent for a specific code when an enrollee sends the initial
exchange message.

After the PKEX protocol is finished, DPP bootstrapping keys have
been exchanged and DPP Authentication will start, followed by
configuration.
---
 doc/device-provisioning-api.txt | 142 ++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index ac204f46..2a34d4ae 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -71,3 +71,145 @@ Properties	boolean Started [readonly]
 
 			Indicates the DPP URI. This property is only available
 			when Started is true.
+
+
+Interface	net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+		void ConfigureEnrollee(a{sv})
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
+			ConfigureEnrollee, i.e. once PKEX/DPP has finished
+			(including failure) the configurator will stop.
+
+			The SharedCode methods have an eventual timeout and will
+			stop automatically after 2 minutes.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.InvalidArguments
+
+		void StartEnrollee(a{sv})
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
+		void StartConfigurator(object agent_path)
+
+			Start a shared code configurator using an agent
+			(distingushed by 'agent_path') to obtain the shared
+			code. This method is meant for an automated use case
+			where a configurator is capable of configuring multiple
+			enrollees, and distinguishing between them by their
+			identifier.
+
+			If the agent service disappears during the shared code
+			exchange it will be stopped, and the protocol will fail.
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
+		Stop()
+
+			Stop a currently running configurator/enrollee. Note
+			that this will also interrupt DPP if the protocol has
+			advanced that far. Since DPP is initiated implicitly
+			from the shared code APIs it will also be canceled.
+			Calling Stop() if DPP was started via the
+			DeviceProvisioning interface will not stop it.
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
+		string RequestSharedCode(string identifier)
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

