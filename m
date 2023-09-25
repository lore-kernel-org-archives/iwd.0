Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502F1C29A
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:48 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f6492b415so45490217b3.0
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668088; x=1696272888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCP5OJlr9budLtvEit5bo/WYeTF14cXms+AeuPeOOXE=;
        b=jppUDEPUzmXSHhODG7WtFvUYekqIx/v+qx+5/HDCuPoxKTluEWgRPXtZFAM4LPu7rG
         w8KqSHNQzUpeGpXYZD1F9lw+21nIJUnU6u4d0YNzM+vkxumaNO8GVozPdIJHtUtaDA0h
         QwtkCSHHnazv7bslkqeV+KGpy2YaSJ0iQjEOR5qkk6w+fw7YofPoK2lF3rddR2F5y9zB
         5nCmPlCwdUabvVJwd1RERVbpC52X35SFsgf4XgRtk7MbQgbgXqQUd22NTqRUdOfMPQTK
         Trc/r4/iIeU7g1DTMHYRBGfi7vARaWzBMS3P2nqmYJyqMy4ru20Txar5VrNTsxAOdnfg
         Dksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668088; x=1696272888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCP5OJlr9budLtvEit5bo/WYeTF14cXms+AeuPeOOXE=;
        b=FHN42js3GKFBUw2y3rQH9kcYhZfc0adDbNX8p5IMj4fcvP8OFAsgHSyS1hCqc2P9jS
         6EDw430K/v9nlJQkY2a7cXGtVEWrgWGICM3aMH5Jp5ss6Yfm3ASzH0MWLP2AJfxVqBk6
         WUMZKDa/YA6OV7Kh29tG4Ha/G0zRcMmQa2WlCld8Tm3zS/nyYIesWY3CqCl5vaDCMyJ6
         1NNgQ8ztDQgOoeoag0qO2mPYL9xPQ1TqdfEJIPs0GegqLY4nVnrk6zs/nvSOEnZKR9yU
         yzafOgzRP3aljhcuNGfUN1mnxWWvXxNoVJuPwac5PBT7BORvYClxBJDLB43qw5BppiXf
         cOJQ==
X-Gm-Message-State: AOJu0YwX2WqP9Bdwr/Fn3XNJZiBWdDPacroxGgR8bhK+sDqvx3FDF1c4
	ul5WopG8u2QE7KVxPaCKf8hGNSaNNt4=
X-Google-Smtp-Source: AGHT+IHps3i+hNQCQVltMVmAjL8e9NHh2KzutYoYK6Dx2oLIc/1QrQwEpVIxCasfVJ0dh9S49V/Ubg==
X-Received: by 2002:a81:6c55:0:b0:59b:e9d5:a41c with SMTP id h82-20020a816c55000000b0059be9d5a41cmr356379ywc.22.1695668087844;
        Mon, 25 Sep 2023 11:54:47 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] doc: document disabling bands with a 0.0 modifier
Date: Mon, 25 Sep 2023 11:54:22 -0700
Message-Id: <20230925185422.2242494-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 294e4c7b..be2fd18c 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -297,6 +297,9 @@ autoconnect purposes.
        Increase or decrease the preference for 2.4GHz access points by
        increasing or decreasing the value of this modifier.
 
+       A value of 0.0 will disable the 2.4GHz band and prevent scanning or
+       connecting on those frequencies.
+
    * - BandModifier5Ghz
      - Values: floating point value (default: **1.0**)
 
@@ -306,6 +309,9 @@ autoconnect purposes.
        networks are highly RSSI sensitive, so it is still possible for IWD to
        prefer 2.4Ghz APs in certain circumstances.
 
+       A value of 0.0 will disable the 5GHz band and prevent scanning or
+       connecting on those frequencies.
+
    * - BandModifier6Ghz
      - Values: floating point value (default: **1.0**)
 
@@ -313,6 +319,9 @@ autoconnect purposes.
        or decreasing the value of this modifier.  Since 6GHz networks are highly
        RSSI sensitive, this gives an option to prefer 6GHz APs over 5GHz APs.
 
+       A value of 0.0 will disable the 6GHz band and prevent scanning or
+       connecting on those frequencies.
+
 Scan
 ----
 
-- 
2.25.1

