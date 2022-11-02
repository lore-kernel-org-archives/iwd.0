Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26872770A
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:40 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id m6so17525552pfb.0
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hOQw+JM1kFwufhWmlhEirrnvCVU7Fu5LUTGIzej0To=;
        b=ZEiv6zdddnkOb//qz9jwRbXeRe++lNrtdyu4fM99ROr3JRaQhMYJUDHmcgW8dsxmk8
         NpqTlQ9RG3jzWkvmRlRr2YbY9m96RxpcBqbG6AY5TZNxtpje0mbbzK844j/nZfT45cWj
         jDwfNEF4AD4yrBbMeqq9YzO9AnUQp97ZMDQlxiQjsEQvn5IGDezJ4BsZUlmMXDy2ToDn
         BWedRdlNHeyHpyYihjSp9diIju9TJYJJh3AiVugT0H17YXbQh5iuQiuFOfhgZXIrQ5yu
         3PFNojuHt5zs1RSjDZZ3P7DP0Mm9Ijsr/ZZeK+UXd0Iq0NJC2/kVJHCmCjNsXckI7194
         RfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hOQw+JM1kFwufhWmlhEirrnvCVU7Fu5LUTGIzej0To=;
        b=ZQZbldKwtuv0FjbB9dOgC7mXbQeu5tCaA1cQIAhPLAXYMHe1gIHVYcoE+6aItbOpC9
         ZqrdYHbzRSUVge0PXh8kGqdT4ru+hxokG3n3/tIXZjgiby7IUzRowd3YU2bSaErXmDGK
         MAoQd2/2Iq05PlzWKn6n/yXwJ2nvC3FnkTFjqGBZDz3K2xk6YtNZxa3WZF5vjaxinQoX
         td17gKwknR15C0VZM91/tCnIwc8mDJIZRDw46CivYBaNWoyCLzwKxjaWiWe7WEScWhdF
         YdFPOmLz6BwG4GnZ9Gfb2V95ZS/FxrhS9euNZcGy9vc1nUZ4LLRJdgRRE5PCjZYsoJr6
         N3JQ==
X-Gm-Message-State: ACrzQf3EoS5OulabDnzneDburQz5Mnytd4D2AFqe8FXEDZWcTGo5oMi4
	OGPlL1udDGNZRG7KcnMqGRAwNLALL5U=
X-Google-Smtp-Source: AMsMyM6fq8PKttY2AkhsasYB/CFX9nIlMZEy4pLAFF+O9oyV9BfcnALLPhQlVghw+i8jCA6QM6L2KQ==
X-Received: by 2002:a63:5a08:0:b0:43c:9fcc:cc54 with SMTP id o8-20020a635a08000000b0043c9fcccc54mr23172909pgb.229.1667422420128;
        Wed, 02 Nov 2022 13:53:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/10] doc: document PairwiseCiphers/GroupCiphers AP settings
Date: Wed,  2 Nov 2022 13:53:22 -0700
Message-Id: <20221102205327.268693-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 5fa23179..ade09e07 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -82,6 +82,21 @@ configuration.
        Processed passphrase for this network in the form of a hex-encoded
        32-byte pre-shared key.  Either this or *Passphrase* must be present.
 
+   * - PairwiseCiphers
+     - Comma separated list of pairwise ciphers for the AP supports.
+
+       Values can include: TKIP, CCMP, GCMP, GCMP-256, CCMP-256
+
+       The underlying hardware and IWD's AP implementation must also support the
+       ciphers listed, currently only TKIP and CCMP.
+
+   * - GroupCipher
+     - Group cipher the AP uses
+
+       A single cipher value the AP can use as the group cipher. Values are the
+       same as pairwise ciphers and the same restrictions apply (hardware and
+       IWD implementation must support the cipher)
+
 IPv4 Network Configuration
 --------------------------
 
-- 
2.34.3

