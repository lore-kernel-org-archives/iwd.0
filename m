Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5401C7B83
	for <iwd@lists.linux.dev>; Wed, 18 Sep 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681214; cv=none; b=FbjO1cC+1wNrCPS3yLCeUBHmZQMRVIEl69LFtJJrGH9ozpUPQNDLumvbS7OS6OvCKcZxsWSuSKMkQApcEnqnhhy9DEWlAYt1TfT2WcA3vwIiR6U+UOYJq1v8iPxCWlm4tnWXrcJG2WLrC268Qkz5maE4ifFGX4FM4pQHWjJnmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681214; c=relaxed/simple;
	bh=pv8rAzQRzFE3tHMD7xmfkmf8XBESUbSXk2gZ0gX+z+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYB8KIJfXPNGzuR5dYUrwks16vGBfzd+j5+CzswmcRUszsa+mBhvRCV+JYBRtLgpBBY+yXco6/gmJcW7wprhNOou+cbbaqfeNOvzlSajBwa9S1Tlt0tCi14QfvM/7U/+QJV+O9J0oCRUTTqtctZ6Upv6XSmOIpCP2gHCHFw1nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7ruHhaa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7ruHhaa"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ac2d50ffso99274285a.1
        for <iwd@lists.linux.dev>; Wed, 18 Sep 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726681211; x=1727286011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKttVFH/1xr4T6pkKau7KMdURXt3Qem6qQ/IEzTnx+E=;
        b=P7ruHhaaqRNz+sttWBVoAgUgCQiGI3VME91UTIsMRUgNW89+r6AX1blmz+2oivghRh
         YPRJD2b78c6YyMymsO2uqeixE0u6Osow2cr6dOELHNjEsCb9hxe4zC8OxqSxBs5ebobN
         t2Ab8TShjjG3tnmA2CYKt3rXHF6AdT22nCXDBiaZ1u7clVTd8YUAArI357PyIjMmh2sx
         /Yqj1qAARyQilABrkZSIg04PKd5Ryj4nNQ5K1iMlix4XY5wDmNI4Rh1T1jL+Vgpd3qxZ
         KxoPPWxy/B0IxYHqz/M6FXkatK+1rVxHfGKII2bqYWc7adVn3pjK/nT6nt/LyvLE2WWP
         zmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726681211; x=1727286011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKttVFH/1xr4T6pkKau7KMdURXt3Qem6qQ/IEzTnx+E=;
        b=PZCCbOjzWanQSBvWLFqaxzQHOVu4r1TpCWLmveH938Cls/UQGB4k5Hlid/yeoh17Qc
         uAFYsmJXlwpGN4T7fd3gxcsItrAQyn3lr/cwDp2bZX+RuuCUDCQ27kLiAR0uAqRhpY7d
         RkwK6HExkQwolSjYGERfIa7eZtin0kyr3diIVZrMA1bC2MADw5HDE79HvVB5QTSB+h11
         xIqcN5lIRgWx3A6aBTr93/Nigs7kXKN9Xb4u54msjkguiAG8q0kE/YZza1O+6ByNKjT+
         DZS8gfmMln45RAlJY4DaLFmBWRzN8lXMQUN3JDaLkRECd433l8INl4jQB4SdtvePgNkF
         h35g==
X-Gm-Message-State: AOJu0Yz57UEGAoIWotU8PkAmhFyQ0hzHboC0oLr8pLiz5VuU3m/+CID9
	gAiIMjnruyOfaeS6tyyLmBbFZqLAeacBRQPOr0IGA+F/61lk3oHPeoczfw==
X-Google-Smtp-Source: AGHT+IHmg+qoD9ir+1KCIaMFCzeeqDpM8kWkiLh1sNr1ZDnHbn9L3ZJL67lt72UsLXgWJxP7ZqKVTA==
X-Received: by 2002:a05:620a:1907:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7acaf5786a6mr60449985a.20.1726681211252;
        Wed, 18 Sep 2024 10:40:11 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95bbc6sm477375185a.7.2024.09.18.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:40:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/2] doc: introduce DPP 802.1x agent APIs
Date: Wed, 18 Sep 2024 10:40:02 -0700
Message-Id: <20240918174002.68663-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918174002.68663-1-prestwoj@gmail.com>
References: <20240918174002.68663-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces agent DBus APIs to support 802.1x provisioning via
DPP. Much of the 802.1x configuration process relies on
concepts that are out of IWD's scope to implement, hence an
agent can be used to enable that functionality.

There are 3 operations being offloaded from IWD into the
DeviceProvisioningAgent:

1. Generating a Certificate Signing Request (CSR):

  The CSR's themselves can use arbitrary OID's that contain
  device specific details. These details may be required
  by a CA server in order to issue client certificates. Trying
  to support this within IWD is not possible to do in a way
  that would work for all use-cases.

2. Sending the CSR to a CA server:

  Besides the fact that IWD should not be doing any TCP/IP
  communications directly, there are a number of protocols that
  wrap CSR's which CA servers can use.

3. Generating the 8021x network profile.

  There are two reasons for this. One is that the CSR generation
  is signed by a private key which IWD does not have access to.
  Since the agent signed the CSR it knows where the private key is
  and potentially what the password is if its encrypted.

  Second, offloading 802.1x profile generation is consistent with
  how IWD treats 802.1x profiles i.e. it does not modify or
  generate them.
---
 doc/agent-api.txt | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index dc5529f3..338d4df0 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -319,3 +319,93 @@ Methods		void Release() [noreply]
 
 			Possible Errors:	[service].Error.Canceled
 						[service].Error.NotFound
+
+		string GenerateCertificateSigningRequest(void)
+
+			This is used by enrollees to request client certificates
+			for the network. When called the agent should generate a
+			CSR containing any fields required for the network (this
+			is all dependent on the network/infrastructure). The
+			agent should then return the CSR from this method,
+			base64-encoded in PKCS10 format.
+
+			To support enrolling to enterprise networks through
+			device provisioning an agent must implement this method.
+
+		void GenerateEnterpriseProfile(string ssid, dict creds)
+
+			This is used by enrollees being provisioned for an
+			802.1x network. This is the last step after the DPP
+			protocol has completed and IWD obtained client
+			certificates (following the CSR).
+
+			Requests that the agent generate an enterprise network
+			profile for the SSID, given some credentials obtained
+			via DPP. The contents of the credentials dictionary are
+			parsed from the DPP configuration response:
+
+			"EAPMethod" :	String value of the EAP method being
+					configured. Note: DPP only supports
+					EAP-TLS currently.
+
+			"ClientCert" :	A base64 DER-encoded certificate (or
+					list) for the client. This should be in
+					PKCS7 format. This is a mandatory
+					value.
+
+			"CACert" :	A base64 DER-encoded CA Certificate
+					(or list). This should be in PKCS7
+					format. This is an optional value.
+
+			"ServerDomainMask" :	Domain name contained in the
+						servers certificate, used to
+						validate the authenticity of the
+						server. This is an optional
+						value.
+
+			The agent is responsible for generating the enterprise
+			profile and placing it in IWD's profile directory.
+
+			To support enrolling to enterprise networks through
+			device provisioning an agent must implement this method.
+
+		a{sv} SendCertificateSigningRequest(string csr)
+
+			Requests that the agent send the certificate signing
+			request to the CA server. How this is done is entirely
+			up to the agent as there are many protocols/wrappers
+			around CSRs to accomplish this. Once the CA server
+			responds with the client certificates they should be
+			returned to IWD as the method return value.
+
+			The return value should contain a dictionary of
+			representing the enterprise credentials. This ultimately
+			gets converted into an "Enterprise Credentials" JSON
+			object (defined in the DPP spec 4.3.5.9) but for
+			API convenience/consistency the dictionary keys are
+			similar to what an IWD 8021x profile expects:
+
+			"ClientCert" :	A base64 DER-encoded certificate (or
+					list) for the client. This should be in
+					PKCS7 format. This is a mandatory
+					value.
+
+			"CACert" :	A base64 DER-encoded CA Certificate
+					(or list). This should be in PKCS7
+					format. This is an optional value.
+
+			"ServerDomainMask" :	Domain name contained in the
+						servers certificate, used to
+						validate the authenticity of the
+						server. This is an optional
+						value.
+
+			The EAP method is assumed to be the same as the current
+			connection the configurator is using. For this reason
+			the EAP method is not required.
+
+			To support configuring clients to an enterprise networks
+			through device provisioning an agent must implement this
+			method.
+
+			Possible Errors:	[service].Error.Failed
-- 
2.34.1

