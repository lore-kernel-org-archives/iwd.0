Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B3183CD9
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477603; cv=none; b=GZZe+RWVLjUMtDeLGWRrC9yzOf8za85AJ4HVGKVqNQ5KNcVeNiLdQYDdrkqoBti7zIw3UCVNmN3Ns1feHvCQkQAqeAAaIQ5+qHVF3M4aNhJlAEZFnr8pZT6HynSt693ehA7utMyGxNCmEPri2rBTZMmdv0KnVpeLiW16j1V9WDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477603; c=relaxed/simple;
	bh=gCdwM5boUrxXJykMfnN7bEjV0cAfhvzuqH+rcGbJXMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7I3uX/76tpPcVUQNeZmx1mrhqxNIM/99wcbZ1vT41KBC6WKbYZWYuzDsA+GcuWYiiGSiPXuNshUXzLokqwshqAsrJEOx33iuL8nCSn5gMx2KWlX9NZOtG9MVB9lBPrVeYRzQ8i+xnsb/46wc6p4sGyeXu9/JjQs4GT2kRS7rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuKC0GXu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuKC0GXu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4404657a12.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477600; x=1724082400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=AuKC0GXueVjduHpPbsHygXTHyUjJSEJ+eZOYldLrtLGGPuKmEOJL8R9Rta+DeG+rjB
         JpfTqpOYVk7iLrkIzmpREIfCt7S1Ct6FN5pjULg1lU4GCpnJHnh3NOYQ+HmEsaQOCz90
         Us8MvKUKkfZOt5rndpKxXfmAzNp9vl3Y26Bo+bFV8qk6FG/9zQPWtxwOq9OAPY08gy65
         WjyjuEjVfqWAfbr2WnjdthiyW6r7OiMztYYW98XPrWvBy0NnLV+o8iYwMlBu20mg9Mxq
         KASUR4Q7NkhhnUQBwVOErqRlqgvYVCfrF4PULsR+Ys6YtD62yi0iYdMV2h9zY+Dz42mF
         1WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477600; x=1724082400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=U2LQTZ6whrrE8Og4f7muLO1h7MgTrvwVFrkzuxGTbOFs45O6g5j6dDsbJJ3TRomYhf
         q74h6LVJw48g6SQM8Te8GQfSbbjZYYQea9GDDKmgsuJpkTwc23bVWYezoZeNscJ1rFwZ
         kNfviVI+8glXL2TvOj52sUoZjF/wz/Yr86pI4zl2eUk5B07c26DFjUQoGXyswPuKYNYM
         h5u3P03sVG2OYWo0P8Ki0tiQfgMLCddY3CiPc3Qv1zFlYSvxeGAyigfcjkBo+cz9xtdV
         yKD2w8h2jQGrvnJZzUNUfWLebPScic8VUcScQc7nWX7FThVSIf5V1NAnbjFAVELBoyda
         1kJQ==
X-Gm-Message-State: AOJu0Yx4/im5SP+YHqkpad99HgtVYeMu/iVAYidPo1/Mwz/V37U5778c
	8FIiCGA2ndZjscELVECmuqjBcia6XG2MzsDU2iVjqNkcmmv711fRqEMcCA==
X-Google-Smtp-Source: AGHT+IFLLWOqdDMX8srVFCYMKQ94O8V2kaelxTG+jM3XL1U2KkOeQiUi2GYrl7r76PGaIoYzRS0ISA==
X-Received: by 2002:a05:6402:3813:b0:58d:81ac:ea90 with SMTP id 4fb4d7f45d1cf-5bd44c7cc25mr494401a12.38.1723477599666;
        Mon, 12 Aug 2024 08:46:39 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 12/13] client: refactor cmd_connect() and add find_network()
Date: Mon, 12 Aug 2024 08:46:12 -0700
Message-Id: <20240812154613.126522-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will do all the lookup/searching needed to find a network
proxy object.
---
 client/station.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/client/station.c b/client/station.c
index affb7f15..58aac29e 100644
--- a/client/station.c
+++ b/client/station.c
@@ -283,28 +283,26 @@ static char *connect_cmd_arg_completion(const char *text, int state,
 	return network_name_completion(device, text, state);
 }
 
-static enum cmd_status cmd_connect(const char *device_name,
-						char **argv, int argc)
+static const struct proxy_interface *find_network(const char *device_name,
+						const char *name,
+						const char *type)
 {
 	struct network_args network_args;
 	struct l_queue *match;
 	const struct proxy_interface *network_proxy;
 	const struct proxy_interface *device_proxy;
 
-	if (argc < 1)
-		return CMD_STATUS_INVALID_ARGS;
-
 	device_proxy = device_proxy_find_by_name(device_name);
 	if (!device_proxy)
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 
-	network_args.name = argv[0];
-	network_args.type = argc >= 2 ? argv[1] : NULL;
+	network_args.name = name;
+	network_args.type = type;
 
 	match = network_match_by_device_and_args(device_proxy, &network_args);
 	if (!match) {
 		display("Invalid network name '%s'\n", network_args.name);
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 	}
 
 	if (l_queue_length(match) > 1) {
@@ -315,11 +313,28 @@ static enum cmd_status cmd_connect(const char *device_name,
 
 		l_queue_destroy(match, NULL);
 
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 	}
 
 	network_proxy = l_queue_pop_head(match);
 	l_queue_destroy(match, NULL);
+
+	return network_proxy;
+}
+
+static enum cmd_status cmd_connect(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *network_proxy;
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	network_proxy = find_network(device_name, argv[0],
+					argc >= 2 ? argv[1] : NULL);
+	if (!network_proxy)
+		return CMD_STATUS_INVALID_VALUE;
+
 	network_connect(network_proxy);
 
 	return CMD_STATUS_TRIGGERED;
-- 
2.34.1

