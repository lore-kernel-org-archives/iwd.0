Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4D3D385
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxBer+6W"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso605261e0c.3
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352046; x=1698956846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Snokl7lM4rWTUuRTvaP7DkGU9WjPBKO+MUbZFtNIfM=;
        b=mxBer+6W/APypAX0i2l+S08rViSY1UjzzLwep776802QtOFOaqrHR8kX3PM2wgHVA1
         Ba1k/5QTcr8k3h/kNkWD2JcgypsEZKBqRZKNGAbYFSKTqicnMbEoH63Kg3Ad25aV5leF
         SAunDfhdARmLMqr5lKTg3NERsMrM9hp9UzOxMCmkQOuZ8XqXgr1EnkUdo2xo9JnDlzCb
         NpSIxCmBYBlGGccGj329RMnY/GESsr0vGdhA0XqFkB2GMFdC9gU6AMPkQqsRkZDGRK8t
         6sMoIkkNnj/OoiIcpFBbeqwZf8Y8i3RYyGEMHrMyYzxNvolmnWgR44Xhm13rHakCLF87
         7w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352046; x=1698956846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Snokl7lM4rWTUuRTvaP7DkGU9WjPBKO+MUbZFtNIfM=;
        b=hx4DSyYtIPW5BznyDzse86p3EqTAOeDt+I4Ve1k4WLXDk9feNsU9OZylDyxgYzCOt/
         s3+C0yfLUlgvVAV5c+fcc2fqDjexGl2JlEH3tnNTlllc/RLDb29DQJdbbQGvrsPm9U+L
         ER/yMMNSYsYOAmTYLzb6YPsgP7E/Qr9aLAmAPsPDNWHoZ7U1oXOzwl9SYAg1h8+AAtPO
         WEm9MKUn+vgKqd5waJZFWZkSLldwu/v44ng4ud5heNhxiwb6s6PDENh7uMiPodPycSFc
         GPX+S/S/QW6nOGsBamygxF3H99+MxqWnG1pIH9MbeRAlZtLKXbITaPG7Hl1rZQ+6MUUx
         +LHQ==
X-Gm-Message-State: AOJu0YzbCwJaEu0lNIwx9k7saXyqCDqPc+LdErkqmpHXBpzY20lN0+Nh
	Zcxar89KmrlH73a35NoNvbFw+zNMIJY=
X-Google-Smtp-Source: AGHT+IHrQlyeAafmosM8zuiHeG/3cE4o6mWvLuZ0RP5VYl8QjNXwSSOcWS6r9qzhVj1Ybvwk1KRyqg==
X-Received: by 2002:a05:6102:44e:b0:45a:d9e0:88be with SMTP id e14-20020a056102044e00b0045ad9e088bemr783215vsq.21.1698352046081;
        Thu, 26 Oct 2023 13:27:26 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/15] doc: PKEX support for DPP
Date: Thu, 26 Oct 2023 13:26:54 -0700
Message-Id: <20231026202657.183591-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
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
static shared code (optionally identifier) passed in with the
dictionary key.

StartConfigurator(object agent_path) will start listening and
wait for an Enrollee to send a PKEX exchange request. Once
received the configurator will call out to an agent
(distinguished by 'agent_path') and request the code using the
identifier sent by the enrollee. If no identifier was sent the
protocol will fail. This method allows for configuring one of
several enrollees, assuming the agent has the ability to
look up the identifier.

StartEnrollee(a{sv}) will start a PKEX enrollee. Enrollees will
begin iterating a channel list sending out PKEX exchange
requests and waiting for a configurator to respond.

After the PKEX protocol is finished, DPP bootstrapping keys have
been exchanged and DPP Authentication will start, followed by
configuration.
---
 doc/device-provisioning-api.txt | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index ac204f46..02856571 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -71,3 +71,70 @@ Properties	boolean Started [readonly]
 
 			Indicates the DPP URI. This property is only available
 			when Started is true.
+
+
+Interface	net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+		ConfigureEnrollee(a{sv})
+			Starts a DPP configurator using a shared code (and
+			optionally identifier) set in the dictionary argument.
+			Valid dictionary keys are:
+
+			{
+				Code: <The shared code to use>
+				Identifier: <Optional identifier>
+			}
+
+			As with the DeviceProvisioning interface, configurators
+			must be currently connected to start.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.InvalidArguments
+
+		StartConfigurator(object agent_path)
+			Start a shared code configurator using an agent to
+			obtain the shared code. This method is meant for an
+			automated use case where a configurator is capable of
+			configuring multiple enrollees, and distinguishing
+			between them by their identifier.
+
+			After starting the configurator will listen on channel.
+			Upon receiving an enrollees initial request it will
+			make an agent call (on 'agent_path') to obtain the
+			code associated with the enrollee.
+
+			As with the DeviceProvisioning interface, configurators
+			must be currently connected to start.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.iwd.InvalidArguments
+
+		StartEnrollee(a{sv})
+			Start a shared code enrollee using the Code and
+			optionally identifier passed in the dictionary argument.
+			As with the configurator, valid dictionary keys are:
+
+			{
+				Code: <The shared code to use>
+				Identifier: <Optional identifier>
+			}
+
+			As with the DeviceProvisioning interface, enrollees
+			must be disconnected in order to start.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.InvalidArguments
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
-- 
2.25.1

