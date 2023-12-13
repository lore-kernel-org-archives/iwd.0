Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89751C31
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB8/cWMP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f040e6722so1266646d6.3
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488362; x=1703093162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fHehrx+dO8/A5vXlJO/eFqyNzFZZ+dkyXtsHXPGhh0=;
        b=BB8/cWMPhuSvrmhSjWDgAjpQu6tChG554WpXJ0OQ1CPiWBu0OVFux+RVgOkOoRIY2l
         CFmmG/AWZulnQ08J49lXQTf+bAqhyqEOZI50A1OrWAeEHL6pfRPfP1KC1H+6f73VFMcX
         LvC0pdk81BQZncz9a7UDy3fYuCmfGMcGsRjfRUBlxxGuHylrCCvMg2mOikzBcTnieSRM
         dq2au17edSgMQt1tv2at1NGWnKqZ+aJZdDA8MoEBUJzTFOaF1i71NOfWVetfozAt0mRc
         w2TAk/HkrQMqY5l7Vhw61/gb1lrYLa0iZ3uM/+h4GVzRDxs+pfrxT9nA03bsy9Uc79tR
         a9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488362; x=1703093162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fHehrx+dO8/A5vXlJO/eFqyNzFZZ+dkyXtsHXPGhh0=;
        b=B2cA/UBwfHEbaUvU81kgwYCj3CTX6SvjrO26evqWi/0fPSNajFr87S0VbxWMHwE+Ly
         8CldDD0UXbu/s/H23Vrx6fbXGzFQKmlYHEt6eqSNWj6qMOZfIFqzBMVIuNFUAjQZP4Al
         dyGnhSORzSvTw1EDwVE3iz6Jk1Opwgrbu+xXhyvVIEkUZpSW+3Eegj4ecssyPdqmTL09
         7ycj1kOcUvOVtpSzJvE6LfcNGrGCu+3pFSV+Ew2A1mgobSws9DrwkhCVJBW9D60Bd2DH
         ZdoKWjXvGptNriGutOuaFJnBk390T9c1zXy2pTywFrrVn6Q3vYtuk0pVjWdT54g776+m
         q1FA==
X-Gm-Message-State: AOJu0YycJ6CUY2lKZ/lIII4EjVomz4uCxbnGYId+wZJKj29Sk63Uie8e
	7/8AEc+7ZkI/FmrStfuU0H+s4QY8UyI=
X-Google-Smtp-Source: AGHT+IE991VQhdkIFoXW+dUt9a2xV1D6R7AzIrFiMwhZRHo/7D0oxCaGAR6MM9NEzf5BcSu+hzvgEA==
X-Received: by 2002:a05:6214:b0d:b0:67a:a721:ec23 with SMTP id u13-20020a0562140b0d00b0067aa721ec23mr5571305qvj.103.1702488361956;
        Wed, 13 Dec 2023 09:26:01 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm556914qtb.17.2023.12.13.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:26:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/4] Fix extra settings not being taken post-DPP
Date: Wed, 13 Dec 2023 09:25:42 -0800
Message-Id: <20231213172546.145998-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current logic in DPP syncs the settings to disk but this doesn't
actually turn an existing network object into a known network, i.e.
sets network->info, which then allows settings to be loaded from
disk via the open() op. Currently a connection can be made (since the
PSK is set into the network object) but any additional settings like
Hidden/SendHostname are not used.

This set is one way we could solve it, though its a bit intrusive
and requires DPP have deeper knowledge that it really should
regarding known networks. It basically forces the creation of a
known network, and I did have to modify __network_info_init to set
the default ops structure, which was a bit nasty. This is the most
direct route without having to worry about callbacks and/or idle
functions.

An alternative way would be to watch the known networks events from
DPP and connect only after an ADDED event. The reason I didn't go
this route was because I wasn't sure about the event ordering. We
need the watch in network.c to be called first (so the network->info
can be created), then connect from DPP. watchlist_add does append to
the tail of the queue so in theory as the above _should_ work so long
as the network watch is added prior to DPP, which is the case since
network's is added in init versus DPP. But I'd hate to put an implied
dependency on watchlist ordering if this changes later. This could
be coupled with an l_idle to avoid the watchlist ordering, but thats
yet another callback.

The scan cancelation patch was thrown in there as well. Since we route
through network_autoconnect/__station_connect_network after DPP there
is no canceling logic and this leads to scans failing after DPP
connects. This doesn't "break" anything but the scans should be
canceled prior to a connection.

James Prestwood (4):
  knownnetworks: set ops on info in __network_info_init
  station: unify scan cancelation
  dpp: fix non-scan connect path in DPP
  auto-t: add a few more DPP tests for seen/known networks

 autotests/testDPP/pkex_test.py | 40 ++++++++++++++
 src/dpp.c                      | 89 +++++++++++++++++++++----------
 src/knownnetworks.c            | 32 ++++++------
 src/station.c                  | 96 +++++++++++++++-------------------
 4 files changed, 162 insertions(+), 95 deletions(-)

-- 
2.34.1

