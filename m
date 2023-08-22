Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E91CA14
	for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 15:29:36 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d650a22abd7so4660703276.3
        for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718175; x=1693322975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJIxGXt0bwhNUSXsRipcMhLfdwZiEkeCSONAzJjOgTE=;
        b=LUQhHkU7gi1Bsdx+gIEl6e4r8GfcWhgDr+6watKjLbzGanosrWQl0Xgc3cC9yHtHoG
         oeqaDexIh4TixrC2nqopTonXmUN+Naa88f5ruPkpMVd8EmZ4xsXIOKb9Qey9U0v66gjM
         bseEd7TOxRu9YNmJHx2Cju1TtlTibyHAcH3kfZgLSU0F4qm2Is2WvJMCM0OI1FA5MAP/
         +3c2YO8vIpdfCo2o+Yd4bZAf4yc9ygWDq84vFsuOvleH6x5QoMJktdk5hx7D8Cs5DeYk
         xLSBO7+TxmhMbsASPfJoZPYbPw8v/jgBnjufYFNlJ+sFbJiSB47i6YuEpSciq0RpTGrI
         P3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718175; x=1693322975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJIxGXt0bwhNUSXsRipcMhLfdwZiEkeCSONAzJjOgTE=;
        b=CjrbpUb3a0Rd2pmK7FJvmk2m91oZixmviJLwZVsdmzeM5yhJ/ncwmVUIfVDihB1lz6
         B+i9kH6jam3Do40XGrIZzU3Z83DYpsvA3eANo7aN1wEN5bhORDH1010mVXsVtMvrGVyD
         OhSHrJbqSz5oTbGtbfgFeEZpeZCOFalXPMi0ook1qFTeRwg7akqlkUhLpOwiu01Gw4ju
         593ddtR0m6VKC0ize+v/LpYmqu+u1/9kS8WXKC9wjjEmVxsVoU87dQoGOiJew/GED+B8
         sKf2Ted9FyH77KsQGV1MoANHzRyR8cT0iOzejoI+B0KOaiZvVqhG0AGGpMsmXsE661Bh
         9HbQ==
X-Gm-Message-State: AOJu0YwPw/0yM1eyAwNC8/eSPqa9uf+JcUnrZjxfY1n50O+zH5EVVqDh
	I5kh+xFy1SzQ6aYqJVxdI3tNcHrw/GE=
X-Google-Smtp-Source: AGHT+IG1F6kmI1k8bFo9bQdXt537VRp9rutevKjvw0+/YdrK4BoOpE1PYNKrrebEO3YPaZDYydLswA==
X-Received: by 2002:a0d:f3c1:0:b0:586:9f37:741a with SMTP id c184-20020a0df3c1000000b005869f37741amr9523225ywf.21.1692718175239;
        Tue, 22 Aug 2023 08:29:35 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j189-20020a816ec6000000b0058fafe95f98sm2108796ywc.114.2023.08.22.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:29:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/3] Support fallback if FT fails
Date: Tue, 22 Aug 2023 08:29:28 -0700
Message-Id: <20230822152931.276136-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its explained as well in the commit description, but we have
run into several cases where IWD continually fails to FT due to
the (only) AP rejecting it with "Invalid PMKID". It appears to
be due to APs failing to communicate current associations e.g.
after one is rebooted.

If IWD can manage to see another AP it will roam, but in cases
of poor coverage eventually the link gets so bad IWD will
disconnect and then successfully associate to the AP that was
rejecting it. This can take some time though and results in
many dropped frames and/or virtually no connectivity.

To try and remedy this we can instead fall back to reassociation
if FT fails with a specific status (53).

One caveat I can think of is there may be additional BSS to FT
to which this logic won't consider until the fallback/reassoc
also fails. This leaves out potential BSS's that could very well
have worked fine. I do think this is a tradeoff though, since
the first/best candidate likely still has the best signal/link
quailty. In addition reassociation is certainly better than
getting disconnected.

An alternative would be to attempt FT to all BSS's, then fall
back to reassociation although I could see this backfiring with
IWD connecting to a better but still poor BSS rather than a good
BSS that just hasn't gotten its act together quite yet.

James Prestwood (3):
  ft: track FT auth/action response status
  station: fall back to reassociation under certain FT failures
  auto-t: add fallback to reassociate test

 autotests/testPSK-roam/failed_roam_test.py |  70 ++++++++++-
 autotests/testPSK-roam/ft-psk-ccmp-1.conf  |   1 +
 autotests/testPSK-roam/ft-psk-ccmp-2.conf  |   1 +
 autotests/testPSK-roam/ft-psk-ccmp-3.conf  |   1 +
 src/ft.c                                   |  37 ++++--
 src/station.c                              | 129 +++++++++++++--------
 6 files changed, 180 insertions(+), 59 deletions(-)

-- 
2.25.1

