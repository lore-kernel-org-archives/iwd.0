Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F343E7145
	for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526282; cv=none; b=oJX9XBVRh5++hzhGqmwX4fpFsuy2kW+7VABzgzGhMieOg40xWlIcDmDWKEg7MPqTQzWt1t1aSkNFwfadnbzq65Gx5HlEBrhHPxlhq8iVI/fV1zPnJRyag69XssgubvKfGcqIuixfCXWDFYssMraHqE2JJ/ZoGo1BUThvWC/fwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526282; c=relaxed/simple;
	bh=D8ckAbtrM4DQFL1kZPQ4gMPH6tSfa1cMo+40rbxRx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMptyGaGct4HdVDDF3MGo7276ErEMyFn7LPfWViO9a2d/vNSOBroovXLjYSSVHEbXEZP5GI7X3/AZraQWadTwP94PiYxbfzEmqcyTwEjNrPe8ZZ5JZLm2xvLxCYFfase7KOxFAB/pN4CuYEKCojPEqoU6SwkGuV97bHE3P6jeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2hKrS6B; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2hKrS6B"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b00d083818so1837759e87.1
        for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526278; x=1787131078; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9wgKy5b8MH11NC4ssO3AjplBG7D2cRynYRYBEkC60U=;
        b=K2hKrS6B+8DczmuHO4pv5W3u1uGbEErdCXtH9eqOUI3GqtGm20Tmo9ppv4TcV/8Y47
         eYJMD/CVkEdjGHtBpa1MPssCGOajJS9zb/ts3Tz7EbhK8gKK3EnPv/tqZWNhlQx1+nCp
         0/TMf6bh/iv9oWACHak1As3nXLhr7j+b46faIcU+/9YjZ9xnwA/F4fzSVG1xnztdYY8Z
         S7UMT6pdv/hAAkQCx1cDinSJ3cHB/aBvnFj0RNVsEJHDTKi84bwn18WkhPHpglBmQAXP
         g3YXwEL1npBAALgQL+COrYVR3Fi/zrpB0rHLW7bNAL+E4he14ivf6PY2/wx+6c07InjV
         UryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526278; x=1787131078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9wgKy5b8MH11NC4ssO3AjplBG7D2cRynYRYBEkC60U=;
        b=HbMO3neKqlYECc8mlEEUpo53TqpB+PaAFxWnQ6A9ltyBLMfPubrSRIlcAtu8PJv3fm
         h12mQMIGVgwNOxYdOk0ddDYfT9Th5ChCJsoPSHgQeS2AZTB+njTMkS5J782RzZuGK2Tb
         LVRyuobz9UU498Y5dNxDi0+SgaSx6uvmWHOQabDMl1dM3h1oi1o79QKEXY8iPVUsGgYJ
         WITmYaCk46+19Yr8FQBr4p3o180meRMq6vbEtk6CFfJlOnRcoED67ov9F4+dWiEna5Jl
         j+cZxIA/XpYaAXJ1rKOVt7GE8x7Ff2ighu7rPBu2QHUm1aOjFWExPFmCJKlg4Tgenjhw
         Bu9w==
X-Gm-Message-State: AOJu0YzPZ6VEG6WIvbhQXVh/4flrLfDTMQ8wKKUan01RHy8RH0wP37W2
	Mt8iydVO89dnuXcO4CPyoilxnNfpbGGeurG+2sSMoyXP+A5EXJ/VVWjxRH4UAzwW
X-Gm-Gg: AR+sD13VaU7YkEjaSEcNijy4Rr26DyptW2/9Og2pwx/b6AsqbJ3jrcOg4nyve0PAjeR
	BxPlx3M6NFTCiaSvZByrSY+9gLzbGiMfy7y508CgXHuflRb9vgJvIJIWZT23xgNc6Pg2B1xuft4
	akixaF0p+XeP+EFW1UuYOTa7HDOqwRM2Ji25Bpvi0s+ELpdu9JlhYotZCoBuDnAawNv5oNimJey
	IKgLYtiCMcpU3xcoqXXrl4MV2ThB9HUo5qfIvuHNu0d6KBfOGa4EnUbAhNmNBH6b70KDvoiVusz
	IMvIX6wLXLg6BLF8fPudoaiquqMkOVV9WL+jpoGCtdewjq0nJ28DeDiYK3K9+RW+0YZzQ1sOlbc
	ere8YlUDoxniRW98+FsHF6p13kSizjgyVw+3HDmn3IB1UKhcg8UJMmmoGu6iVdttsjeJPuooJAa
	bSJ4slRB6GZUJR4YI+3F5t4CMS8HqAtr7DuUKdnOwY/+2ptjnc75rUG4uYSWkzLybhFWhhu2UmM
	zswEK+Xx/0Fxw==
X-Received: by 2002:a05:6512:2903:b0:5ae:b62b:68b2 with SMTP id 2adb3069b0e04-5b44b8e661cmr1048103e87.2.1786526278311;
        Wed, 12 Aug 2026 02:17:58 -0700 (PDT)
Received: from aai01 (dtuguest20.nat.net.dtu.dk. [130.226.71.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d024cfesm370474e87.45.2026.08.12.02.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:17:57 -0700 (PDT)
From: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
To: iwd@lists.linux.dev
Cc: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
Subject: [PATCH 2/2] agent: clear pending_id on request timeout
Date: Wed, 12 Aug 2026 11:16:52 +0200
Message-ID: <5033e58b9c9305efe61f91b1757a4337f0424c33.1786525748.git.intimyp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786525748.git.intimyp@gmail.com>
References: <cover.1786525748.git.intimyp@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_timeout() cancels the outstanding call but leaves
agent->pending_id set. agent_finalize_pending() pops the last request
and agent_send_next_request() returns early on the empty queue, so the
stale id survives with nothing queued.

When the agent later drops off the bus, agent_disconnect() tests that
id and calls agent_finalize_pending() again, which pops NULL off the
empty queue and dereferences it:

  #0  agent_finalize_pending (agent=0x..., reply=0x0) at src/agent.c:187
  #1  agent_disconnect (...) at src/agent.c:511
  #2  _dbus_name_cache_notify (...) at ell/dbus-name-cache.c:188
  #4  name_owner_changed_cb (...) at ell/dbus.c:861

agent_receive_reply() and agent_request_cancel() already clear
pending_id in this situation. Do the same on timeout, and guard
agent_finalize_pending() against an empty queue.

Fixes: d04ab5ad96b4 ("agent: call back even if agent disconnects")
---
 src/agent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 0f718b87..5adee5dc 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -183,6 +183,8 @@ static void agent_finalize_pending(struct agent *agent,
 	}
 
 	pending = l_queue_pop_head(agent->requests);
+	if (!pending)
+		return;
 
 	switch (pending->type) {
 	case AGENT_REQUEST_TYPE_PASSPHRASE:
@@ -230,6 +232,7 @@ static void request_timeout(struct l_timeout *timeout, void *user_data)
 	struct agent *agent = user_data;
 
 	l_dbus_cancel(dbus_get_bus(), agent->pending_id);
+	agent->pending_id = 0;
 
 	send_cancel_request(agent, -ETIMEDOUT);
 
-- 
2.55.0

