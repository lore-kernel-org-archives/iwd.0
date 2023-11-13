Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275622309
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEJdB5qJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-671357f0209so29933866d6.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699900087; x=1700504887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qEJmOEkljxkK/ENkxomQMbC6EA/aMDwSdvNH1Umlaw=;
        b=TEJdB5qJg5UY+uEV0TLKwBDM54L0AW3VXA7i0434BzBYl0oMsWVZFstxKfpozkeKN4
         ejC1JJwfl3fklsNP6Gz+d9xuaYNsQrxme9xQjzKJqDGjNQIgG9hDIR0LIqGGSJRdPm5k
         hK6oAPvniWudVUQRtsJtfi2O5PRNzxLIvQzTFzQhE6VHj+o+t/lWGGkN0Q/ZIrNybwWn
         Od6NJXDpdf5mSkpO8G3fKrSf39tIhf5iSokW5PY7lMHFWNRqjJ2jAzPDu9zc4NYa6bNi
         Bz01hVi/mAKOy5BEo8iOBaqEGW3dlj16oTHk3PIcU714bLmv/N0svKqFdlfZzRkY0JRd
         QMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699900087; x=1700504887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qEJmOEkljxkK/ENkxomQMbC6EA/aMDwSdvNH1Umlaw=;
        b=dta+mgq9pFsIqzrVI2uSTT8LCTeyfP4NDVpBl86YD30Ask39Bi5OC20nbooeDOTOfv
         AKFJGFlx/jYtrr66iSKFAH3fuQc7sSBUPKuvA7yQHueOyXrpEAaf6Yss23PBK0zDkL3d
         m4oz3v2yGVR9iDHTJ3a/e2qUa5fxdOx3m/PzPNmQO1KTb/AooIS3OWUS38yFrD+Q4kMs
         1mh/5d4JslrDorZgDKvznNDfysxCOuhHmrT1iY+wFqiZpm7Ic2W7n0bljNPGdsnZzWWo
         r7Df62h6OveiDKxbPi7BJzv1E890HlMpcHqTBVJNbXEZI7ALdPmmHgVSJA2BkC12Wad4
         D0eQ==
X-Gm-Message-State: AOJu0YwYrqJhitY7PlCrhy5y+paSrodtHzQHV4hojXKcysHCsV3Jrs0j
	tDlb7ANqY0MT3yoI8L904S8h3fTMZ58=
X-Google-Smtp-Source: AGHT+IHXNYi+iuPofDGoMgb4x58jBzcD+B/OkFQlZ/8LLRP7YduQIPruwZ+5jckt/ikZzkaxKuefEA==
X-Received: by 2002:a0c:e7c4:0:b0:65b:765:254 with SMTP id c4-20020a0ce7c4000000b0065b07650254mr34823qvo.4.1699900087624;
        Mon, 13 Nov 2023 10:28:07 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x13-20020a0cfe0d000000b006710660a548sm2240121qvr.27.2023.11.13.10.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:28:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] RFC: Support full profile sharing via DPP 3rd party attributes
Date: Mon, 13 Nov 2023 10:28:00 -0800
Message-Id: <20231113182800.344348-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an IWD profile contains network-specific settings which are
required to utilize the network correctly configuring via DPP
will not carry over those settings to the enrollee. The DPP
configuration object only contains the SSID/PSK to connect and
anything else set in the configurators profile is not included.

This is likely something that the majority of users will not
need (most networks don't need additional settings) but if the
network does it would be convenient for the configurator to send
over its exact configuration to the enrollee. This is useful for
an automated use case where a configuration should be consistent
across all devices.

DPP allows for arbitrary 3rd party attributes in the configuration
object (section 4.5.2) which can be used to communicate additional
settings.

The plan is to define a new object within the overall
configuration object who's keys are IWD profile groups and values
are objects containing settings for those groups:

{
  "ssid": "my_ssid",
  ... main configuration object ...

  ... The IWD profile, converted to JSON ...
  "/net/connman/iwd": {
    "Network": {
      "MutlicastDNS": "true"
    },
    "IPv4": {
      "SendHostname": "true"
    },
    ... etc ...
  }
}

The "/net/connman/iwd" object could then be parsed by the enrollee
(potentially if the feature is enable in main.conf?) and set to
the profile as it is now with the passphrase/psk.

Several profile values don't apply here like MAC/IP address
overrides. Mainly the settings that do matter would be:

[IPv4].SendHostname
[Network].MulticastDNS
[Settings] (most values here, except AddressOverride)

The other IPv4/v6 settings likely aren't useful since they
pertain mostly to static configurations and are obtained from
DHCP. The [Security] group would be omitted entirely since its
already set by the main configuration and contains generated
values like SAE-PT-Group's.
---
 src/iwd.network.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 719853fa..8f4e54f9 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -440,6 +440,25 @@ network configuration.
        value obtained from the DHCPv6 server or via Router Advertisements.
 
 
+The group ``[DeviceProvisioning]`` contains settings for device provisioning
+credential sharing.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - ShareFullConfig
+     - Values: true, **false**
+
+       When configuring an enrollee, include all additional network profile
+       settings except those that are device specific (e.g. MAC/IP address
+       overrides). This uses 3rd party attributes in the DPP configuration
+       response and will only be compatible with IWD-based enrollees that can
+       parse those attributes.
+
+
 Embedded PEMs
 -------------
 
-- 
2.25.1

