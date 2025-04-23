Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F119F48D
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416507; cv=none; b=PbP7kO+kmaUyBpjNz5BZuC+L7MY3RcDI5Z0+jx11liCH8hVDN9QWCfxLa0w4DcirwjXO5NPGX3fKT16cKWGnC+7vIkBxq71O3JInpIU1pHPLoRxrsKzfDTiDcJLtB7Efjnx7fRiTxDJAAAef6qfG4WQwQGAWFjzlhlVYSGG7TQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416507; c=relaxed/simple;
	bh=wRe2sA0gqfv2eaPaUsK9dyCbpXBn1eyzkm1QW0DM9Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mig0HrPzvD98qc/1ia4YsGEhqnS51GmJPbYtC7HHVZtOxcsu1ZIWoQCPJea48wmfkdScgzInn74kMsWajLSt/YU+oC6tEz7vs/Ydu9TpdZy1upJG1dVCdQ7X5YKDXq0E4rZ4Dm7ufXqItGNwpCNGkLRhUbXlDSmY7iyonSm7RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1FFxF7m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1FFxF7m"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47691d82bfbso121828401cf.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416503; x=1746021303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9GL1pLIQVdRuPeHwkFgloHeaOgykEi8K5deu1CiZkk=;
        b=Y1FFxF7m+1omQ8Q0/1KHxlZZuM+YXK8KJcHr5Pz9QbBsE2thbDzRSyZm46llqPEKqC
         du6iuWfyMGLeHI52LJQ2FOrQKewukKJfEGuBekDwJAJpju6+zLOH5EPGunMRx0SgqaDe
         3aHaTiQmBDKtxW69rCOVVwrv7yvbB3ByaqOSATCckrK4cA//nYyOeaKt84zARGQimdaE
         qi6MMSLaC5VnhQuSfuNYOw1epBKVpZgbUlz9B06AWl8gxG4WXJ+9l3TciToeB0hAmo/T
         uX4AA2Q6pXD0cqz1eMV/xa8QW9PgmD94NeovEilEPT4MDE+s0T3lDAAgW0nE/rv+YZJB
         8mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416503; x=1746021303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9GL1pLIQVdRuPeHwkFgloHeaOgykEi8K5deu1CiZkk=;
        b=qea/MlsPj4aZLTmVzK/mVx9E+wlkI4tqb92S5ecTob64b9UXu4nMpT9uMs0lbFNxo7
         LAnqfHMqtKYjNDxrYZLPVnbJBKI6YT+qbtn7Yd1A8SYAbz5BaZoUf+mVgzdteHRpuXd1
         AdCvIPSegRV2WGvGd2inrbZqLdUo2qddXf3iGUFyUndd/ecp17U6n6hiYXVSQkN8VIsk
         xo9DP+0huIk1AeNJCpgHTBFlHArarq2xBlNElWTs0Ztoa79ylgN75iPcW1wZ8uPG7sW+
         JTi2dgw/3GExmrjrkZxYdz6EmsCAfJM7jz0BMRoiZWGmld7bic+3ojFQFNzIEel5bvDT
         X+yw==
X-Gm-Message-State: AOJu0YxqD0Zg7ZZF450jblbTHUHhUV018SMtOji5iqF8w2O6DA+VCfny
	Hp58k66Gh0qsh862BkvEwZAPp9Zv11FRFQexxNEhivMzSk2gDPcGNiaBIA==
X-Gm-Gg: ASbGncvwe+NqIjtOOI3FceDp22Qw9ac6YHqoM9LaZFLPO8YBgGvffDNmeV8Cva5Urjj
	pOy/DjALkvRAOtgsKzEpGTwhzSAm5P2opt46+p/63W0CwBXkSqN7xpR1EC5F2uEPr5VMr+dy5x3
	Oa8nHzHySNVgGrrFeFmQQw/IykVvFE8IK467ZT9zTie24xerEIc7OoD0X7BinMcMeL88LD8LlG5
	sgBRuyU7YuJnocxMPoqoL9RXpnY9wkto2N6rHIhIUODmy9fZ+7g50/atkzIxJmg3x23wQV8FVnr
	76dq8ZCtRyFaBm/lImaML27AWkjL04t9sX2mjhlCi16GlTosjw==
X-Google-Smtp-Source: AGHT+IGA1dZPJIYpXexXZCjXyvc2DfMuFsM563uUi27S9iEW+8T9XfUxFdWytVdL7mk4FGHJvU/TnQ==
X-Received: by 2002:a05:6214:1250:b0:6df:99f7:a616 with SMTP id 6a1803df08f44-6f2c450b178mr385556006d6.2.1745416503531;
        Wed, 23 Apr 2025 06:55:03 -0700 (PDT)
Received: from LOCLAP699.. ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b32741sm70733576d6.62.2025.04.23.06.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:55:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] client: add SignalStrength/Frequency properties
Date: Wed, 23 Apr 2025 09:54:56 -0400
Message-Id: <20250423135458.11337-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423135458.11337-1-prestwoj@gmail.com>
References: <20250423135458.11337-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/bss.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/client/bss.c b/client/bss.c
index def4de7f..19355f0b 100644
--- a/client/bss.c
+++ b/client/bss.c
@@ -32,6 +32,8 @@
 
 struct bss {
 	char *address;
+	int16_t signal;
+	uint32_t frequency;
 };
 
 static const char *get_address(const void *data)
@@ -57,8 +59,52 @@ static void update_address(void *data, struct l_dbus_message_iter *variant)
 	bss->address = l_strdup(value);
 }
 
+static const char *get_signal(const void *data)
+{
+	const struct bss *bss = data;
+	static char signal_str[7];
+
+	sprintf(signal_str, "%d", bss->signal);
+
+	return signal_str;
+}
+
+static void update_signal(void *data, struct l_dbus_message_iter *variant)
+{
+	struct bss *bss = data;
+	int16_t value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "n", &value))
+		return;
+
+	bss->signal = value;
+}
+
+static const char *get_frequency(const void *data)
+{
+	const struct bss *bss = data;
+	static char freq_str[5];
+
+	sprintf(freq_str, "%u", bss->frequency);
+
+	return freq_str;
+}
+
+static void update_frequency(void *data, struct l_dbus_message_iter *variant)
+{
+	struct bss *bss = data;
+	uint32_t value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "u", &value))
+		return;
+
+	bss->frequency = value;
+}
+
 static const struct proxy_interface_property bss_properties[] = {
-	{ "Address",       "s", update_address, get_address },
+	{ "Address",        "s", update_address, get_address },
+	{ "SignalStrength", "n", update_signal, get_signal },
+	{ "Frequency",      "u", update_frequency, get_frequency },
 	{ }
 };
 
-- 
2.34.1

