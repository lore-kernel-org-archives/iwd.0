Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695F13A87E
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303129; cv=none; b=Vx+7TSIII1J4Q5qrUyzd4XPBZtaqeoF5/d7VpxTU2PBzGmAeE6+KoeyMUEl5DZGrUk0EU1hpehyJNsa93+TEIyUxwTP0pFVY0UZ4iLComurcCk6F1i8RiE6+9X0dQXwUrUgDPAcMTF5Bd4Ga9/X67aGWOQHXIzgn3EhW5rc+aUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303129; c=relaxed/simple;
	bh=mzX37m6OwHWnkSgdkOmcYRlQPz9kWsaW8faDpeKPdTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TY6n2wKtqiRCC+crDKs2lBOEr3s173zay5dkkoq1DY4jw++TO6Skbv5cluRTkAiRxchGqNZM1nCY6hU6D8SZLPouFiGSM+PdAf3DzGDK4CPzcpzc5fl4gehUs1UrKp4SiURvdYvMcTyQ+uLJlrpzTrNqhLR1ZwNfvePmwETh12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVeRAU1a; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVeRAU1a"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b760dc7e08so4927296d6.3
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303126; x=1721907926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJu/qFP10T4RXl8ll9a0J6IDXFcKvBXWY5vbx00wIVI=;
        b=PVeRAU1adS2WrCAjJjNS+Jv4QrQnFPLn7huegCWXIOLcEMjf7gJodaW4T3WRJ1NwIC
         yoX+XqBIMzU6992UfaCOENtgVxEPGFas8qIBstU5JI4y101h3p8GWxkGXsE2Spp2sBGg
         8wPbW9BbLX6ujnduOw6TD49MrZhhdFcQ4IdLBjXZmMASBdktTctp6EZlJuMiA+jke4xH
         EuozVU6z46GCS1HZadOmsB2OIvUwvCFUHaKQWwwvRQDe8w4V7eTVZpdj7OjL+APU/F50
         3nSDgF/wu0uWXIn12acqdjfWzUVyuf/RugIlyeX6331QrvxEiOyCE0a/ybYEQBrv5kFx
         7UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303126; x=1721907926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJu/qFP10T4RXl8ll9a0J6IDXFcKvBXWY5vbx00wIVI=;
        b=hmEGf40QUIkfjgrHhQwnxbIjl4/y3NCKn1vKkWRumWFDUaBV+uGdgMUaFHFzsuS03Q
         3mpZWyWU9wc1PfPAtNK39qihXvDYjOxHt4wJTINpnWDskHJybeiSRw/GOzxAwVMcjCNi
         qMomx96T56yeqI3ZpG6RWIpLl0J2/NV/jzRRthR9CKD7PXH24DBQdiBedLX1ZFDY5foA
         oDO81fuvgIat4TD7zHz2SaLsrWr+XnEjLDANbPo+clydq3YQVMCBMVbogcgbYlkpdVme
         KAh7+lU9SuRp2myOZ63ePzVeBP8pvdQAf2t+Hdl2KsUyZA4D5ftAgR9fGVj0HyrpSr2x
         Tm2Q==
X-Gm-Message-State: AOJu0YzoA15ZiiPkEng6/NRUie1E6sSJBIWijPwW6LcICaFaXSF35Lq+
	LFLTRI0ZaBCHv/GTTl3umqu1UDFUBjbZbtpmyt1EtwWzuZIQ+nNWT+gTrA==
X-Google-Smtp-Source: AGHT+IH6LJ15FZD9c9PBNtqTcQfbwLfHJv+PhnTStWy6WLNaHLWXhIeh/R+QB3CqJIYBL65NdWMifQ==
X-Received: by 2002:a05:6214:2349:b0:6b1:e371:99d3 with SMTP id 6a1803df08f44-6b78c8deb22mr59514356d6.0.1721303126444;
        Thu, 18 Jul 2024 04:45:26 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/11] station: add handshake-started debug event
Date: Thu, 18 Jul 2024 04:45:10 -0700
Message-Id: <20240718114514.2916258-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 62b05c35..ca0e6a38 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1015,6 +1015,7 @@ static void station_handshake_event(struct handshake_state *hs,
 	switch (event) {
 	case HANDSHAKE_EVENT_STARTED:
 		l_debug("Handshaking");
+		station_debug_event(station, "handshake-started");
 		break;
 	case HANDSHAKE_EVENT_SETTING_KEYS:
 		l_debug("Setting keys");
-- 
2.34.1

