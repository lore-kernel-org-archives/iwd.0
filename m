Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EFC952
	for <iwd@lists.linux.dev>; Tue, 21 Mar 2023 16:19:24 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id br6so19806694lfb.11
        for <iwd@lists.linux.dev>; Tue, 21 Mar 2023 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679415563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUXlA5nbIAHrgBoReQkM2tmqQwYdBpixjzZ2/CM+79Y=;
        b=OcMQc1ZdO8sZlKNKmJQz+5ghWvP9z3MAOioGmeokQpzbfcm+ZZtkaULx5DncUPKzCX
         QqTGByJ4ANyfeXhkpK9Yi2HF7avLuVNTgyrQzg261DwW2Q42Chi1lRVFU2jH0A7b/8GW
         u7gyqSaW5lmkaIKMtj9ZbO8PszD4mdl0gw1s6EehM8LgJuXRxQu9wRF6q/lzo3c7DVub
         eyojc4TX5E0qI0EsXiHkmB7LWS7r9JstCnD8DTpff3yIUl3bFrmuQ4u6UNKvnzfHPCIt
         wuGlQmk2cmBIVv7Z9gekssGCnex0R90mujbtm9CAcblZRhOH9yz42fQJulKPlOSao2Cw
         bXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUXlA5nbIAHrgBoReQkM2tmqQwYdBpixjzZ2/CM+79Y=;
        b=WWgqrhptEogjumuCAHkpgq2vyYmLZy37knby1ljUSSW2RCAq2Pzkn7ho12uAHhNaXA
         efc5lpRHoGMNlZ9J7/osvIf47ZPuZAsbRfQXI0kOTMpaeIbmF4tfozgz+xJXWDT5jxiy
         9vr2y1kOKCYEXLhAwMs1UBKBCBap/NdwXK74dFnAGauvRmwahZMEDS9+e6FzDmyQ5Kvc
         JtZWIApzj1kecSTxH7nPhXFjnhtWqE+omJdWY5TdP2cKzaaAvmhYvvPknQSFpAHlNVCf
         snPXpT7q4TbXWyja/Y2/A4wcrSMZpVyCxb3bOVpxHlGqEbFHq4bTyPkYlAf1R+YYHkHn
         SzbQ==
X-Gm-Message-State: AO0yUKVEhyiCcvefAUKXdg6DURor/W8kHqA4oAupKQPBzEH1oA506vxY
	BFupVEIppr+d1q2BsyBX1fsoSx17p/E=
X-Google-Smtp-Source: AK7set8WhYu2dJTD/QA2ohB3yu8Prfr7ldJWYREurw4pZKqX5X0KTiZiudwbtNi6po9vWTGNhJMhEg==
X-Received: by 2002:ac2:520b:0:b0:4e0:dfd0:fa9 with SMTP id a11-20020ac2520b000000b004e0dfd00fa9mr984896lfl.56.1679415562998;
        Tue, 21 Mar 2023 09:19:22 -0700 (PDT)
Received: from nl6720 (balticom-231-46.balticom.lv. [83.99.231.46])
        by smtp.gmail.com with ESMTPSA id t18-20020ac243b2000000b004e92c0ed7a0sm2222645lfl.100.2023.03.21.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:19:22 -0700 (PDT)
From: nl6720 <nl6720@gmail.com>
To: iwd@lists.linux.dev
Cc: nl6720 <nl6720@gmail.com>
Subject: [PATCH] man: enclose referenced man page names in bold
Date: Tue, 21 Mar 2023 18:19:05 +0200
Message-Id: <20230321161905.161909-1-nl6720@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Man page parsers will autolink appropriately formated man page
references. The most common format is to have the page name in bold
followed by the section number in brackets.
---
 src/iwd.ap.rst      |  8 ++++----
 src/iwd.config.rst  |  4 ++--
 src/iwd.debug.rst   |  2 +-
 src/iwd.network.rst |  8 ++++----
 src/iwd.rst         | 14 +++++++-------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 9ad002a2..7bc81186 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -33,7 +33,7 @@ method is used.
 FILE FORMAT
 ===========
 
-See *iwd.network* for details on the settings file syntax.
+See **iwd.network**\(5) for details on the settings file syntax.
 
 SETTINGS
 ========
@@ -62,7 +62,7 @@ The group ``[General]`` contains general AP configuration.
        Note: Due to regulatory requirements the linux kernel does not allow or
        strictly limits 5GHz use in AP mode while in world roaming. These
        frequencies become available once the country is set, either via IWD's
-       main.conf option ``[General].Country`` (see ``man iwd.config``) or
+       main.conf option ``[General].Country`` (see **iwd.config**\(5)) or
        externally (e.g. iw reg set <CC>). If you are having trouble using 5GHz
        ensure the country is set, and that the desired frequency/channel is
        unrestricted.
@@ -122,7 +122,7 @@ IPv4 Network Configuration
 
 The group ``[IPv4]`` contains settings for IWD's built-in DHCP server.  All
 settings are optional.  They're used if network configuration was enabled as
-described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
+described in **iwd.config**\(5).  Omitting the ``[IPv4]`` group disables
 network configuration for this access point so if an all-defaults DHCP setup
 is desired, the group header line must still be present:
 
@@ -230,4 +230,4 @@ The group ``[WSC]`` fine-tunes some Wi-Fi Simple Configuration local parameters
 SEE ALSO
 ========
 
-iwd(8), iwd.network(5)
+**iwd**\(8), **iwd.network**\(5)
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index b3dc22d4..93f845fe 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -35,7 +35,7 @@ chosen.  The presence of *main.conf* is not required.
 FILE FORMAT
 ===========
 
-See *iwd.network* for details on the file format.
+See **iwd.network**\(5) for details on the file format.
 
 SETTINGS
 ========
@@ -381,4 +381,4 @@ The group ``[IPv4]`` contains settings related to IPv4 network configuration.
 SEE ALSO
 ========
 
-iwd(8), iwd.network(5)
+**iwd**\(8), **iwd.network**\(5)
diff --git a/src/iwd.debug.rst b/src/iwd.debug.rst
index 3d4c8b58..7ca17de2 100644
--- a/src/iwd.debug.rst
+++ b/src/iwd.debug.rst
@@ -47,4 +47,4 @@ The granularity of the DHCP logging can also be tailored by setting
 SEE ALSO
 ========
 
-iwd(8), iwmon(1)
+**iwd**\(8), **iwmon**\(1)
diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 719853fa..f7128336 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -133,14 +133,14 @@ The group ``[Settings]`` contains general settings.
 
        If enabled, the MAC address will be fully randomized on each connection.
        This option is only used if [General].AddressRandomization is set to
-       'network'. See iwd.config. This setting should not be used with
+       'network'. See **iwd.config**\(5). This setting should not be used with
        [Settings].AddressOverride, if both are set AddressOverride will be used.
    * - AddressOverride
      - MAC address string
 
        Override the MAC address used for connecting to this network. This option
        is only used if [General].AddressRandomization is set to 'network'. See
-       iwd.config. This setting should not be used with
+       **iwd.config**\(5). This setting should not be used with
        [Settings].AlwaysRandomizeAddress, if both are set AddressOverride will
        be used.
    * - TransitionDisable
@@ -180,7 +180,7 @@ Network Authentication Settings
 
 The group ``[Security]`` contains settings for Wi-Fi security and
 authentication configuration. This group can be encrypted by enabling
-``SystemdEncrypt``, see *iwd.config* for details on this option. If this
+``SystemdEncrypt``, see **iwd.config**\(5) for details on this option. If this
 section is encrypted (only contains EncryptedSalt/EncryptedSecurity) it should
 not be modified. Modifying these values will result in the inability to
 connect to that network.
@@ -541,4 +541,4 @@ PEAP + MSCHAPv2
 SEE ALSO
 ========
 
-iwd(8), iwd.config(5)
+**iwd**\(8), **iwd.config**\(5)
diff --git a/src/iwd.rst b/src/iwd.rst
index c719fbc2..bb6e9c04 100644
--- a/src/iwd.rst
+++ b/src/iwd.rst
@@ -44,19 +44,19 @@ OPTIONS
 ENVIRONMENT
 ===========
 
-*$STATE_DIRECTORY* is used for network configuration files.  See *iwd.network*
-for details.
+*$STATE_DIRECTORY* is used for network configuration files.  See
+**iwd.network**\(5) for details.
 
 *$CONFIGURATION_DIRECTORY* is used for daemon configuration settings.  Only
-the file **main.conf** is currently read from this directory.  See *iwd.config*
-for details.
+the file **main.conf** is currently read from this directory.  See
+**iwd.config**\(5) for details.
 
-See *iwd.debug* for further environment variables for debugging.
+See **iwd.debug**\(7) for further environment variables for debugging.
 
 SEE ALSO
 ========
 
-iwd.config(5), iwd.network(5), iwd.debug(7), iwctl(1), iwmon(1), hwsim(1),
-ead(8), systemd.exec(5)
+**iwd.config**\(5), **iwd.network**\(5), **iwd.debug**\(7), **iwctl**\(1),
+**iwmon**\(1), **hwsim**\(1), **ead**\(8), **systemd.exec**\(5)
 
 http://iwd.wiki.kernel.org
-- 
2.40.0

