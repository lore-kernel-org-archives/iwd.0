Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2636127
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:45 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id r204so1518610oie.5
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A905O3m3o5kthDoiJTtkx1OzXE58O7aDsZLCw1j9tyQ=;
        b=AcpemlENZgnoWsfGs0odkEu70btDkJWtxTF01Nr7w/K1k44GIv/ac0yMrStfDpVF9/
         2/rNSPkMrQKmO9XdDHA9MdWNKrDO9G4DdY2Q/eE5AHvRA24zGpql8B7UTDu6K+49M1+p
         pGU0oPYEuf/gNwk0m4hODCOi79g9rRr9d01lZUL+6b2Uf8sEX2YYNqJh8pMGGD7deBN/
         9cXVAPVqpJC2qG7w2QlRw8uBP34BD1RB/N+uF48KbPqB3HN6ySWp1xONZrwrtXsLqsX9
         qdBTge53PJzXh6BGi+QmMu0kBWnL6kE3k60hve44PW64bTISEkWBpUY4yDJtB2ilXDD1
         5iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A905O3m3o5kthDoiJTtkx1OzXE58O7aDsZLCw1j9tyQ=;
        b=XcyYZhclJ5YdTnH48yq/o8n+KY2y6OEKxnbboUDyWNIzQTIQvN1HnmTj022Etr9q0Y
         pP2mhN/UqRKkSfkn6phNC8n0CJp15GDnjmsRNwzj+jVbPTgvVkN34gg75ZTsecs5qpYZ
         I99UDHiw1e4If66ukdGNiv8uU+0WU6WghaNoHv8TYcaMmP8pndMI/IkWPTrI6xNUWCUR
         vn/uq6JJbiIfsr9vCj1rdhxIqwPi5fWxpi4ck/iZBqQRkKuk0IuFbBf1bN8NzigbOeWY
         yhhvEz96UDF6YCv7gSdlAL6jKmbdQchsmpTIMcNVItZgi4t3DvqikDHpatxzs5qo2JYW
         R6xw==
X-Gm-Message-State: ACrzQf006xVuBwSwZN0hVI4DY/SYGDY2Kv/MYZrvUGnVKdJ29LRL2zqv
	QeTDz89W0nzs0fEbGwERuOokWlYvxgQ=
X-Google-Smtp-Source: AMsMyM6hG2lM9HIR9Aq/8FzHE5jpje7KkEMvRjYn6HgA1x7TJOHif9tAjloJmBq+bYujjai0WOmdlg==
X-Received: by 2002:a05:6808:13ca:b0:354:bd5b:c2b7 with SMTP id d10-20020a05680813ca00b00354bd5bc2b7mr11034908oiw.118.1666379623929;
        Fri, 21 Oct 2022 12:13:43 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/26] wiphy: Generalize supported cipher dumper
Date: Fri, 21 Oct 2022 14:12:52 -0500
Message-Id: <20221021191307.31492-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make it easier to support additional ciphers in the future.
---
 src/wiphy.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3e08047910e1..da4610d094d5 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1120,7 +1120,7 @@ static void wiphy_print_band_info(struct band *band, const char *name)
 
 static void wiphy_print_basic_info(struct wiphy *wiphy)
 {
-	char buf[1024];
+	char buf[2048];
 
 	l_info("Wiphy: %d, Name: %s", wiphy->id, wiphy->name);
 	l_info("\tPermanent Address: "MAC, MAC_STR(wiphy->permanent_addr));
@@ -1135,18 +1135,33 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		wiphy_print_band_info(wiphy->band_6g, "6GHz Band");
 
 	if (wiphy->supported_ciphers) {
-		int len = 0;
+		int n = 0;
+		size_t len = 0;
+		int i = sizeof(wiphy->supported_ciphers) * 8 - 1;
 
-		len += sprintf(buf + len, "\tCiphers:");
+		len += snprintf(buf, sizeof(buf), "\tCiphers:");
 
-		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_CCMP)
-			len += sprintf(buf + len, " CCMP");
+		for (; i >= 0 && len < sizeof(buf); i--) {
+			typeof(wiphy->supported_ciphers) cipher = 1 << i;
+			const char *str;
 
-		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_TKIP)
-			len += sprintf(buf + len, " TKIP");
+			if (cipher == IE_RSN_CIPHER_SUITE_WEP40 ||
+					cipher == IE_RSN_CIPHER_SUITE_WEP104)
+				continue;
+
+			if (!(wiphy->supported_ciphers & cipher))
+				continue;
 
-		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP_CMAC)
-			len += sprintf(buf + len, " BIP");
+			str = ie_rsn_cipher_suite_to_string(cipher);
+			if (!str)
+				continue;
+
+			len += snprintf(buf + len, sizeof(buf) - len, "%s%s",
+					!n || (n % 4) ? " " : "\n\t\t ",
+					str);
+
+			n += 1;
+		}
 
 		l_info("%s", buf);
 	}
-- 
2.35.1

