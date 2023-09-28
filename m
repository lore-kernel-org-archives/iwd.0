Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE1374EE
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 12:41:32 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c3bd829b86so104121285ad.0
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904892; x=1696509692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCP5OJlr9budLtvEit5bo/WYeTF14cXms+AeuPeOOXE=;
        b=Fv5UKP4unw7yOE5b8+1zAjeiFINa0xaFludDG1IttwCTkdFxfA+GGArDJoeUS8QhJj
         RchP0OgD+kn7NOyJD0aFitjiK3rP6xIqDgmnITEsBaJVNIm2LTWtnWXGBSrZF2kbQYNJ
         xcYs3H8UlGmDTG2NySHOv6ooxvphYaeUPxNdIB2DRq7OcLQ6vHPA/f2haFrS2syQbU0L
         9oGpKttp7xlmG2jVaOgebcqTZJNTf9rwGyf4TTSB9OGtoqpZQICuujHTxfkaY/Huv/K/
         WKhiTiJXB9H8/KPjCcO4Kj41FCaOXk97+t3Md9I14JJ8uKbq9uOsZnK5/i13N+aTsdF+
         AZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904892; x=1696509692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCP5OJlr9budLtvEit5bo/WYeTF14cXms+AeuPeOOXE=;
        b=gJPir3CApunOrPxefKCV6gFYMpgyZfkV68o7c2Em/00J4sL/6T8s61Y+82DmGB1ukU
         b7LXbzC+R17C2wtezTCGu4r7HnRLbOxyT23s62s5BisjN/yDOfAO7nfAwmnJSzQekc9b
         BlxTcLn6bgP6+STS+KAETp9YICKB5VCxLbGGkQPoaVfmcJjuk4QkkoWJXFIM7pkJbh49
         V5tkl/dV2oclC8eg/7Cx9o/JMSvEpuWPjfpKXIu0IS6WbZj3C+H/a/2OSM3hZ6aMR73x
         ursFAP9btVyJCvw5pFeTaKZ/TITRICJvG9RYv4mH1SYsbndwl4jV+ZcOe3VMfBbUVe9L
         xsGA==
X-Gm-Message-State: AOJu0YylUZRysJ8CVDWyM8CiZnjMtfA8vm02XTHd7NnoV2YfwrTMUwXW
	WTTPj2M3OBFk1/xe/6hrkUM8A0lTAJo=
X-Google-Smtp-Source: AGHT+IGb2r/ZHAS08V2al6Z86ESEhQ7lsAnaMwAyPn3PVF9gupmZAkeL5Ii8MGGURzbxxKsukLz3JA==
X-Received: by 2002:a17:902:7d92:b0:1c4:4c0f:8d91 with SMTP id a18-20020a1709027d9200b001c44c0f8d91mr1000555plm.69.1695904891936;
        Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm14983105plb.25.2023.09.28.05.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] doc: document disabling bands with a 0.0 modifier
Date: Thu, 28 Sep 2023 05:41:28 -0700
Message-Id: <20230928124128.3793788-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928124128.3793788-1-prestwoj@gmail.com>
References: <20230928124128.3793788-1-prestwoj@gmail.com>
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

