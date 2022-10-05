Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4146A6
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:37 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d10so365784pfh.6
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ej1kxWqr+4YBO6yxHSGVkadXykZ/rsokrIOIDlC57Jk=;
        b=Tcwk5/7EzOB0cwc5zTHJy/t4y5n0ik7LNx/fRlq/8kLbBhiKsEED1dhe5sacnrC8/h
         rNtvI2GPhXVTdth7umOYt3gpm59OOoRKXdJWvVNy5rXGfJAEGSXitvNEk/I/y/8mAjSY
         qcUNclGJUwYaQY0My80fmOZcKJk1/bif98R4I1w6BXvOZ88skBufyy2hYGULQxFF4O8M
         /bK5NQ3q/tgAUzRB4s68stjh2PvOp5Fr9mdvLrmaJdl9bzDcJ/+05wF6MAWxwyCU3enC
         Vh1hhMrKQ/+wUqOHqoF4BNUrvMHm1nINU3JEfTlwhy68uKo1vLQtLumI7NTkFDg5eDu8
         wkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ej1kxWqr+4YBO6yxHSGVkadXykZ/rsokrIOIDlC57Jk=;
        b=qr3ekboQ0jUlmG6Rbf9dymW5AAYMSfzPY12GtYVpp7nYFlmUasrNg7kWCjafpHljeK
         2gAWbotoLZhhxhJ7cOshnHKrQl6KoqOr0Lm3raet/iVsySllt4h+rsjMNCg0Scr8gJjR
         MvMT7+gdpPHJEyQJzoj+Hx4Ny2CalJ5GEPJYd7Gn98ks4sq/K+xZBtqZ+829/EJ52eUp
         bZlkVZsErk1qTKLxs3cGX8TxEzZG68xyM2dR9Gx3RdIY/LL5zDeNCQsvjQOSyDrlEmUn
         FGX/HsP+bCxZ/W34GpTdfBIa7RbKMKFDBa8fLQTwsZrpBz/Ajar6EnzfqUhIT9NAzmxJ
         6xuQ==
X-Gm-Message-State: ACrzQf08lBs0nrICro9ePVQpdUUrr20pmRxWcE/OgDG6XI4GifDvsgz3
	3yXUO7MC6K5puRRTyKjk6iLGYRSKQZg=
X-Google-Smtp-Source: AMsMyM59zWOXe/FDABDoy/1kf85AQBesOe3DcUGIFJkePghzXDC7e5mMOtNbMFy2fGlNfavSLkbO0g==
X-Received: by 2002:a65:6e0f:0:b0:43a:1cd4:4ae6 with SMTP id bd15-20020a656e0f000000b0043a1cd44ae6mr1712664pgb.289.1665009996866;
        Wed, 05 Oct 2022 15:46:36 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] auto-t: remove rekey timeouts from autotests
Date: Wed,  5 Oct 2022 15:46:29 -0700
Message-Id: <20221005224632.780575-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
References: <20221005224632.780575-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any autotest which rekeys will do so explicitly. There is no need
to potentially introduce an unexpected rekey.
---
 autotests/testFILS/radius.conf                   | 2 --
 autotests/testFILS/ssidFILS-256.conf             | 2 --
 autotests/testFILS/ssidFILS-384.conf             | 2 --
 autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf   | 2 --
 autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf   | 2 --
 autotests/testFT-FILS/ft-eap-ccmp-1.conf         | 2 --
 autotests/testFT-FILS/ft-eap-ccmp-2.conf         | 2 --
 autotests/testFT-FILS/radius.conf                | 2 --
 autotests/testPSK-roam/ft-psk-ccmp-1.conf        | 2 --
 autotests/testPSK-roam/ft-psk-ccmp-2.conf        | 2 --
 autotests/testPreauth-roam/eaptls-preauth-1.conf | 2 --
 autotests/testPreauth-roam/eaptls-preauth-2.conf | 2 --
 autotests/testSAE-roam/ft-psk-3.conf             | 2 --
 autotests/testSAE-roam/ft-sae-1.conf             | 2 --
 autotests/testSAE-roam/ft-sae-2.conf             | 2 --
 15 files changed, 30 deletions(-)

diff --git a/autotests/testFILS/radius.conf b/autotests/testFILS/radius.conf
index 1ec52e46..f8f2b596 100644
--- a/autotests/testFILS/radius.conf
+++ b/autotests/testFILS/radius.conf
@@ -11,5 +11,3 @@ fils_realm=example.com
 disable_pmksa_caching=1
 
 pwd_group=19
-wpa_group_rekey=30
-wpa_ptk_rekey=30
diff --git a/autotests/testFILS/ssidFILS-256.conf b/autotests/testFILS/ssidFILS-256.conf
index 66d4bfb5..1ee9fc8f 100644
--- a/autotests/testFILS/ssidFILS-256.conf
+++ b/autotests/testFILS/ssidFILS-256.conf
@@ -17,6 +17,4 @@ nas_identifier=nas.w1.fi
 fils_realm=example.com
 disable_pmksa_caching=1
 
-wpa_group_rekey=30
-wpa_ptk_rekey=30
 ocv=1
diff --git a/autotests/testFILS/ssidFILS-384.conf b/autotests/testFILS/ssidFILS-384.conf
index 5254d5f8..57ebe6e5 100644
--- a/autotests/testFILS/ssidFILS-384.conf
+++ b/autotests/testFILS/ssidFILS-384.conf
@@ -17,6 +17,4 @@ nas_identifier=nas.w1.fi
 fils_realm=example.com
 disable_pmksa_caching=1
 
-wpa_group_rekey=30
-wpa_ptk_rekey=30
 ocv=1
diff --git a/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf b/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf
index a7f220d9..5a04668f 100644
--- a/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf
+++ b/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf
@@ -17,8 +17,6 @@ eap_user_file=/tmp/secrets/eap-user.text
 ca_cert=/tmp/certs/cert-ca.pem
 server_cert=/tmp/certs/cert-server.pem
 private_key=/tmp/certs/cert-server-key.pem
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 disable_pmksa_caching=0
diff --git a/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf b/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf
index 289d7a17..98754fd1 100644
--- a/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf
@@ -17,8 +17,6 @@ eap_user_file=/tmp/secrets/eap-user.text
 ca_cert=/tmp/certs/cert-ca.pem
 server_cert=/tmp/certs/cert-server.pem
 private_key=/tmp/certs/cert-server-key.pem
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 disable_pmksa_caching=0
diff --git a/autotests/testFT-FILS/ft-eap-ccmp-1.conf b/autotests/testFT-FILS/ft-eap-ccmp-1.conf
index 1853ff70..4dbbfb50 100644
--- a/autotests/testFT-FILS/ft-eap-ccmp-1.conf
+++ b/autotests/testFT-FILS/ft-eap-ccmp-1.conf
@@ -15,8 +15,6 @@ ieee8021x=1
 
 fils_realm=example.com
 
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 disable_pmksa_caching=1
diff --git a/autotests/testFT-FILS/ft-eap-ccmp-2.conf b/autotests/testFT-FILS/ft-eap-ccmp-2.conf
index 585f1ca1..5f341bcd 100644
--- a/autotests/testFT-FILS/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-FILS/ft-eap-ccmp-2.conf
@@ -15,8 +15,6 @@ ieee8021x=1
 
 fils_realm=example.com
 
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 disable_pmksa_caching=1
diff --git a/autotests/testFT-FILS/radius.conf b/autotests/testFT-FILS/radius.conf
index 1ec52e46..f8f2b596 100644
--- a/autotests/testFT-FILS/radius.conf
+++ b/autotests/testFT-FILS/radius.conf
@@ -11,5 +11,3 @@ fils_realm=example.com
 disable_pmksa_caching=1
 
 pwd_group=19
-wpa_group_rekey=30
-wpa_ptk_rekey=30
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index c012b4ef..4a2ceba5 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 rsn_preauth_interfaces=lo
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index 84875fdc..a42e175d 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 rsn_preauth=1
 rsn_preauth_interfaces=lo
diff --git a/autotests/testPreauth-roam/eaptls-preauth-1.conf b/autotests/testPreauth-roam/eaptls-preauth-1.conf
index dac086e6..5b4c9d6f 100644
--- a/autotests/testPreauth-roam/eaptls-preauth-1.conf
+++ b/autotests/testPreauth-roam/eaptls-preauth-1.conf
@@ -7,8 +7,6 @@ wpa=2
 wpa_key_mgmt=WPA-EAP
 wpa_pairwise=CCMP
 ieee8021x=1
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 
 # Run the RADIUS server in the BSS 0 hostapd only, listen for BSS 1 connections
diff --git a/autotests/testPreauth-roam/eaptls-preauth-2.conf b/autotests/testPreauth-roam/eaptls-preauth-2.conf
index 6d3a18e7..edb97fe0 100644
--- a/autotests/testPreauth-roam/eaptls-preauth-2.conf
+++ b/autotests/testPreauth-roam/eaptls-preauth-2.conf
@@ -7,8 +7,6 @@ wpa=2
 wpa_key_mgmt=WPA-EAP
 wpa_pairwise=CCMP
 ieee8021x=1
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=1
 
 # For EAP connect to the RADIUS server in the BSS 0
diff --git a/autotests/testSAE-roam/ft-psk-3.conf b/autotests/testSAE-roam/ft-psk-3.conf
index 8918cf9e..705f2e6c 100644
--- a/autotests/testSAE-roam/ft-psk-3.conf
+++ b/autotests/testSAE-roam/ft-psk-3.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=2
 disable_pmksa_caching=0
 # Allow PMK cache to be shared opportunistically among configured interfaces
diff --git a/autotests/testSAE-roam/ft-sae-1.conf b/autotests/testSAE-roam/ft-sae-1.conf
index aa40494a..bccac375 100644
--- a/autotests/testSAE-roam/ft-sae-1.conf
+++ b/autotests/testSAE-roam/ft-sae-1.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-SAE SAE
 sae_password=EasilyGuessedPassword|mac=ff:ff:ff:ff:ff:ff
 wpa_pairwise=CCMP
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=2
 disable_pmksa_caching=0
 # Allow PMK cache to be shared opportunistically among configured interfaces
diff --git a/autotests/testSAE-roam/ft-sae-2.conf b/autotests/testSAE-roam/ft-sae-2.conf
index 5bff6c9d..bb7ecff4 100644
--- a/autotests/testSAE-roam/ft-sae-2.conf
+++ b/autotests/testSAE-roam/ft-sae-2.conf
@@ -13,8 +13,6 @@ wpa=2
 wpa_key_mgmt=FT-SAE SAE
 sae_password=EasilyGuessedPassword|mac=ff:ff:ff:ff:ff:ff
 wpa_pairwise=CCMP
-wpa_ptk_rekey=30
-wpa_group_rekey=80
 ieee80211w=2
 disable_pmksa_caching=0
 # Allow PMK cache to be shared opportunistically among configured interfaces
-- 
2.34.3

