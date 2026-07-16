Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DD2D63E5
	for <iwd@lists.linux.dev>; Thu, 16 Jul 2026 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169379; cv=none; b=E616oG1dhcL5wfVh8MZIUtAA5tj8X7OidHH+MaVshbNlQ6KcXhlAQZEfpojzTLojKiXt30GXG6p9JfVlrhL6yN7G4PDf8CcSK1uuDqHcsK8YPLu9guNH821YDSVprYQkiaSTQTPkIsLnVfMWhaT5hE2llHqd3l9VLTBV6jhOcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169379; c=relaxed/simple;
	bh=/kYWvf3kcOOB2Vc92FhrYOF3xGPPqpUAtrO1PKGgYXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GW3gRuD6hcnHTDlP1Gp7yVGi3PIPRRKJWD7NhE5zcSkxPfh+9CGMiRqPLBP4twEvC+djXb0ylHi1yXWdFwPCJwCD0s2E0D9OXxs4Xo/v2fahadf6OAt7y1ewRi8REhVy35jTCbw8SjMY3V/fUD18bKKwAakVAW2vbLo1Ak2ul0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j25Gca8/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j25Gca8/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-388b404ea89so103994a91.0
        for <iwd@lists.linux.dev>; Wed, 15 Jul 2026 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169377; x=1784774177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=539+87JXJkKCFtam7joNX6ojXs/ISl3tpfysd//gctw=;
        b=j25Gca8/4t628B/b/HpfqyILdB/5yoU6BD+4vsIM/svUj3V23AN5pjxLDV49tQgYNu
         6tkef0BqnaeP812qyoqhEY1VmnDyMNOr91A2OeP3W3PvIlA3g6KoXF664tHdUyW0/5l8
         nrRlFL1J2Sg1m402KVD42C5NoiET8A1G8C0bafrajUbVXliQ+GXehIJZ797lKHM9z9qZ
         xwEpx7Zw7sN4Xp0aoCdMBamccN5Idg64gHXTsJ5hdO65RfuSP77aYDN3HmHJ/9IIU7BF
         wL2Xuv6kHs3tTtKETsCNbvmqwiaslEcrd6+G6IEdE0s4u2CLOobi27R0n1PzwXl+/bSd
         1X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169377; x=1784774177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=539+87JXJkKCFtam7joNX6ojXs/ISl3tpfysd//gctw=;
        b=Kc0vvbuccb3HaHbZD1MTOLGs28DhervEZ0FXKpnwWuVx7mo8XS4lPVkq+7Maobk+aN
         kpFk6z6Up0MxbZ/WlVf0a74mfY+pvU2AkOQiUiHhyZuGH3xjd3aUb2sMAUBABueO8tz6
         CKeVjBxovzw3NcnrJ0tWQlFp871Y9sYE/8OpucEGF2DRoZK+Cv6G20GinoZBQsQ7vYSV
         tWHPcm8n54ZlPDP7seVRFAa7a683uZUzFGrQ5t+dLcYopS4XoDjcdfASxM86pmn5HnkQ
         RCAtbI5eCvbHfQjfYZBo5JBW3kMRpt7HMYLW9I9IF4PjR+LxbHg1x/OH9TtLQuRiup+M
         1HYg==
X-Gm-Message-State: AOJu0YyAK9OlXT4UisR87VJOBk3kQvk6GIJRLeXRYjs+cSdz86Wb/iSo
	9cGZAI45o13WnyXkrIsQApLJJaMKneF3dqz/ZrKYWt22Zv8XLOhpFWR84Og3wbA=
X-Gm-Gg: AfdE7cnZzJMcY3hINytk/2xs3QrL2UzJUvay12IQI/tsKwpibVNqoIqbM4ZxrokFNIa
	Vw8hgo/9geUJfCjH7xXY9Ewqdjk4i5Cm9sz8qg/eWKUUiRyRXaR3DkKwVVtOuAtFDIGklf5oBW1
	KpBktWeaF0uQcR8Vv/ZSFkqkCrdTZAfKjjw8xxSPp4gjSRoBfc52JAixvHeWlyPh3q8fykXpieL
	4vJ/nHRhIpCijCE3h0B6MGw7qZeHZpHC/itogjEhLmn+Ywmqw005TJIzD/x/S+Jx1l00Cou3bwN
	oEyMh9pu1tNSoYdxurVNni9FB1TPsjKgkQ8JT/D5buV/JmqDEO7fRJl+GGQ9WIxqskb+5jf9oWC
	/v9grhLtqYZV8C9dESPaPcZotBrxcCZos99SDqNlacMgHKFcs3mWdJZnDpDZFycG8L9wG18mSy2
	jisSvQAqvvPjKh+Jg4Q40pxCLhZPqfEQsqwPFvQA==
X-Received: by 2002:a17:90b:2dc7:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-38e3d19b8famr768663a91.9.1784169377360;
        Wed, 15 Jul 2026 19:36:17 -0700 (PDT)
Received: from matic1.1020marsh.offices.matician.com ([2600:1700:471:807f:aff0:107f:e34:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e5306afsm6060595eec.9.2026.07.15.19.36.16
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:36:16 -0700 (PDT)
From: Suchir Kavi <suchirkavi@gmail.com>
To: iwd@lists.linux.dev
Subject: [PATCH 0/3] Fix two station roaming crashes
Date: Wed, 15 Jul 2026 19:34:41 -0700
Message-ID: <20260716023444.3512595-1-suchirkavi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We run iwd on a large number of embedded aarch64 Linux devices
(WPA3-SAE, frequently multi-AP mesh networks) and root-caused two
recurring segfaults from coredumps and journals. Both are present in
current master by inspection, and together they account for the
majority of the iwd crashes we see on current builds. Heads up that
this cover letter and patchset are primarily AI-generated (Fable) but
reviewed by me.

Crash 1: use-after-free of handshake_state when a reassociation
overlaps a pending connection attempt.

netdev_connect() refuses to start while an attempt is pending
(netdev->connected || netdev->connect_cmd_id || netdev->work.id ->
-EISCONN). netdev_reassociate() has no equivalent guard, and the
station layer can invoke it mid-connect: station_cannot_roam() does
not cover the connecting states, connected_bss is already set while
connecting, and station_roam_scan_notify() does not re-check state.
Captured sequence (journal shows "state, old: connecting (auto), new:
roaming" in the same second as the crash):

1. A fresh SAE-H2E connect is queued behind a scan - the auth proto is
   created holding its raw handshake pointer, netdev->work is queued
   and never starts (sm->group_retry == -1 in the core).
2. A roam scan completes mid-connect -> netdev_reassociate() to a BSS
   with a cached PMKSA. netdev_connect_common() takes the
   PMKSA/CMD_CONNECT path, so netdev->ap is NOT replaced;
   netdev->handshake is swapped; old_hs is unreffed here and the
   caller swaps station->hs - both references gone, the handshake is
   zeroed and freed under the stale auth proto. netdev_connect_common()
   also re-inserts the already-queued embedded work item, linking the
   same wiphy_radio_work_item into the queue twice.
3. The scan finishes -> the connect work runs ->
   netdev_begin_connection() sends the CMD_CONNECT, then starts the
   stale softmac auth proto -> sae_start() -> sae_choose_next_group()
   reads sm->handshake->ecc_sae_pts from the freed (zeroed) handshake
   -> NULL dereference.

Core anatomy: sm->handshake points at zeroed memory plus allocator
metadata; netdev->ap == sm while netdev->handshake is a different,
live handshake; station state == ROAMING.

Patch 2 adds the same guard netdev_connect() has. Both fields are
zero at any legitimate roam start since netdev_connect_ok() completes
the work item, and the station roam paths fail a rejected roam
cleanly - except station_preauthenticate_cb(), which is missing a
return in its error branch and falls through to handshake_state_ref()
on the new_hs it just unreffed. Patch 1 fixes that first so the new
error return cannot widen it.

Crash 2: station_ap_directed_roam() dereferences connected_bss before
its own state guard.

station_disconnect() clears connected_bss (via
station_reset_connection_state()) before entering DISCONNECTING, and
the WNM frame watch outlives the connection - so a BSS Transition
Management request arriving in that window (mesh APs send them around
disconnects; our journal shows connected -> disconnecting 2 s before
the crash) crashes on the ignore_candidates initializer that runs
before the guard meant to drop exactly that frame. The invariant
"state == CONNECTED => connected_bss != NULL" is otherwise sound -
the unguarded sanitize memcmp just below already relies on it.
Patch 3 assigns ignore_candidates after the state check.

Suchir Kavi (3):
  station: fix use-after-free in preauthenticate_cb
  netdev: reject reassociation while connect pending
  station: fix NULL deref in ap_directed_roam

 src/netdev.c  | 3 +++
 src/station.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.54.0

