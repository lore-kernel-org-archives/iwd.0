Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5461674
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350018; cv=none; b=j7lj3lSUN2sg2eQM3HNHjT1Aa1eo3BdgRaL7/9FGmuaCXflFcXSQWIUilThROlpQBGbNSw5bl76YuB3ndA6VoWcxUE5/ba4wRDGsMmDbpFSa6g8zEinuIVUlN7cQL5ph4ksgn4qRUKXHPMxqrtxRn8lUXygpkVfPZ2i19CAFngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350018; c=relaxed/simple;
	bh=J870Fv4sA0zXqXgcI4YnTzqjpxC4hh2zxIOEiNG+N3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJGhJe5yu8KTdJnKLu5wtOC/2zABjLNI/+gIqwc1o/Z357aoDlK3NYW6AlHvP6PMXp5dDFrlHBktyia+zJS+SI0ZUHkO1jAR04h+SGQuOYd67zusE20aXMUK7IeEkIKoNCSZ5qEWb6do3ylZDeDbeNGr6vd0VG/w70FQTw4qnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K98fgnAG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K98fgnAG"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so4347685a.0
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350015; x=1710954815; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uBLbpsVQC2IBq6Gm9jdCmW/Qbx23eY3gUKCWDLmp7U=;
        b=K98fgnAGd1lRJXn4wxptP1nlwpBfSFtgim/918z56v6nBcG7s5djz64wSDn2dRT2D6
         YvdhYcAyOPHXqV2o+8nCv+277kwz9KLUKJe0Qg1646vIqP72bItIkHFH/B0gDyCzdXoz
         xRgXKiwrN63Z3RFxwnWGgEYi9RlkW0jwiUw26JanIUDBbS4n/aDTPINfHxLRR19cELH7
         e6da2zXf0/u7lFWRKLJcAbHJQzSTWs5xuG7TcbSxN73VA1m6L0Ua3ONhk45mNharv4u0
         yDk+uQKFv7NQJ/bDefbSLegH6wnn8lI6zVDazvbM8mHAoUIMgUT6A6g98hVZe81iDsod
         dmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350015; x=1710954815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uBLbpsVQC2IBq6Gm9jdCmW/Qbx23eY3gUKCWDLmp7U=;
        b=WqS1nWY4r97em3Bdr4kvaPLj7R7Zb1Mv+L5edurAqPJI/Rcle82+XnBfDKZlQIMh5k
         jwUnLbT5ZASJCL5JepyWMXuFHsIIG4KzhORdcyjNMqdIgXXlu2/hZjwl1nOAqIiywd0n
         J/yjBvSlPHzUbjfWKLQd9+N7Jh/o+R+1GYfT9qrLWQz7Vsu778JiERwot0ChDTaYLs2U
         TsFM5MmwWTkTwHl9ylULkQF+FYzV18UiG2tABrnbW0gzg8q6sLpn1phLakFZeTuzZJPN
         OV0gvtfgrqlY8/xqYaj5FIfHYJU2eudyP2GbppcTt/mKhtJL3sOw34qL7yoYhjW1a4d8
         YaWw==
X-Gm-Message-State: AOJu0Yxu8PSovPcz5NK8j7dmm6G8CqOeaGi6vZ+pe1onYYuqlMwg3pgo
	YC/lQdA15klMFn0YgfHQ0agMka4ty9e7BKgGvtfxGcdPyziwnNeHi1Pv+BHd
X-Google-Smtp-Source: AGHT+IEM8Zm1Ra6AsOKbvPCDI1OurINJXZskQqUjReDfu1cdHWWwVuXss0/9xzON2OlmdUxz1TW0sQ==
X-Received: by 2002:a05:620a:1a0b:b0:787:f739:9836 with SMTP id bk11-20020a05620a1a0b00b00787f7399836mr554111qkb.52.1710350015097;
        Wed, 13 Mar 2024 10:13:35 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id i4-20020ae9ee04000000b007882e204d45sm4927136qkg.37.2024.03.13.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:13:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/5] Initial prep/skeleton for isolating core DPP protocol
Date: Wed, 13 Mar 2024 10:13:06 -0700
Message-Id: <20240313171311.695830-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1-4 can be applied any time, they are needed for the refactoring in
further patches but are still a nice improvement on their own.

Patch 5 is the skeleton module for the common DPP code. Don't merge this now
(even if it looks fine), I'd like to at least get the TCP side started before
I lock in the dpp_sm APIs in case there are changes required.

The reason this is being done is to eventually support DPP-over-TCP as well as
add the ability to implement a DPP controller within the IWD source repo which
can use the same state machine as IWD. Doing this requires the TX/RX of DPP
frames be offloaded to the encapsulating protocol (802.11 or TCP). This leaves
the DPP state details within the SM, which can be shared between either
protocol.

James Prestwood (5):
  dpp: prep for moving AAD within dpp_append_wrapped_data
  dpp-util: move AAD logic within dpp_append_wrapped_attributes
  dpp-util: add dpp_append_point
  dpp: use dpp_append_point
  dpp-common: Skeleton for common DPP module

 src/dpp-common.c | 517 +++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-common.h | 109 ++++++++++
 src/dpp-util.c   | 180 ++++++++++++++++-
 src/dpp-util.h   |   7 +-
 src/dpp.c        | 308 ++++++++++++++--------------
 5 files changed, 948 insertions(+), 173 deletions(-)
 create mode 100644 src/dpp-common.c
 create mode 100644 src/dpp-common.h

--
2.34.1

