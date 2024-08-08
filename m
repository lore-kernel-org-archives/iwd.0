Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AB1917C6
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138971; cv=none; b=m2Z1QRBbB4yBdbdptC1sf5q/cs4EbOoeVVKLKLUn/d8kjCIYX9VLfYN3UOYq0yCITOjCJbEdk3q+34TzTK3yO9gmzGrtUrMr4he3ZbI0Pwnr4OSh0kSuOSXGMJe9DtOyeiXtCkSj0w6gD6EZa5rUNwMojMGIIZQVnXBh4EL60V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138971; c=relaxed/simple;
	bh=gCdwM5boUrxXJykMfnN7bEjV0cAfhvzuqH+rcGbJXMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIWJqRjyJ87Crcu/NEh3NVZYOhXyX4CmxqSiBh4TGv9/nI72r/kk0eJkyouQGY3C1M2YyrBK9kerfv9gtE3t6AL3qN2fQ0mK4bGZWHTRqGOmryiKeR8F7amFxIX8hJqf+1yWtkdHXUe0xgc24XVJPbxxKrtSkiixv/ag/K7RWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEEgaFWr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEEgaFWr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc65329979so12285405ad.0
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138969; x=1723743769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=CEEgaFWrtCjWj10jLIEryBk26qRGtcj1Kj97eMjdRQR6ZjBo7HD8QyfPt739ycvFTc
         C9oiKLFpVcYNOCgAPX1wdQIPGG49cEMrbJ/Ig8EBe5cZHs8uBEG9dL9I6HEbzcgqOo61
         vHzHmvqNSb5j8VwpWyyIS/4AxpYeAjFtsEvXwMNY4UHClX3+apH8uuVo4yPKEFWduB7b
         Uoe4WuqMXpTyd/kso1375y+O8wqaP44YkDG/TDKlEeuHx7taEoDUOB7vqFGTjgYWSdvG
         08FpeE2DbTFOWtNoVkSGmSOAod1r+Zi/mtmKcJYy0TRYxi/VE9opcA+6BvE39f4Eegf+
         yCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138969; x=1723743769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=cJn3t2h15UbQiTJHIDcxXD/YRQt2uoE5EtpUaL2g40lalbdikkAEpXDE1Kg7tExUUL
         s9DHIn+cOzBMYGVmJQd5u6XH9os4UAh4Q05bdI5iEXz/jJaMRsbWNHlxy4WQJh8A+Zdt
         27Qc4WnoiTPkKYrZeFwBD35eQ39Ym4+A7V/9yj1owbjZpzKkpNliLvzDz/nSQPirxpqN
         dHxbbjz3mNx4AA8ACrq0d6yHVl0/XqhzZ/YYsXVmdBKuiAGjlAIma21uXcXzO5JaadVa
         c8pglEbUBslhwJKJCd3HxCg6Ivvxn/D3wrhaYupdLQvpZKqXADbRQT5Gp1j8OkJQ+Y10
         MGtg==
X-Gm-Message-State: AOJu0YyiZPU6mqbNccBcBhXHwqNu3cvG+JrE6R3WqohBb+Wme8l5hHdb
	VU9IcA6bYe3AqlNtuxuBwwJjFl9xUpjemcUHMs/CpYqAMrFAR0cAt13+Jw==
X-Google-Smtp-Source: AGHT+IExikKOzJezC0/KL1XT41O/iKxXUElSEW71g+fTJgM00gxxZp6FpLQ4uPdSQMNVQlSjkKclkw==
X-Received: by 2002:a17:902:f68a:b0:1fd:a043:e3de with SMTP id d9443c01a7336-200952bef5emr30471455ad.40.1723138969006;
        Thu, 08 Aug 2024 10:42:49 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/13] client: refactor cmd_connect() and add find_network()
Date: Thu,  8 Aug 2024 10:42:35 -0700
Message-Id: <20240808174236.218750-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
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

