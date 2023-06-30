Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63500171BB
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:26 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-635de022557so15190676d6.0
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152705; x=1690744705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elubSlhv16wVSeqGt7uy60RmjTzmrTBhFe/rY3LeK8M=;
        b=KGkQfCB8DiZ1pFNDZa0sTRqMGAkSMuRv6sP10Z/IhSvFXE4BpkyxztS4VuYoeqD4tQ
         /QtWieKw0XTRpkBBcIGp6jeE28EsOb2JpSx33fWDC7oJGTvVXrhejEW67ddgOXYrChru
         jOnLBK5ntQlf38DsIxhxATpAPAJ6ThdFJSzGR2Omnu9wX+rSI+B+76DKnue5x7tKr6vP
         CF/BQhU2GK7Y7mhJ5MIA1A5x6mc34rCoKHb4pT2tc5WT5rAOThe83IsGJYjWM364kbJA
         ZaBD1AAY6eUB41Yjqt4pligPA0+w19sjF/bLM/v6FuD8Xp/hBp9+DSkdxUXHza0gGBXp
         AQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152705; x=1690744705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elubSlhv16wVSeqGt7uy60RmjTzmrTBhFe/rY3LeK8M=;
        b=gB1qRBzYz0uOaARwobePg1nwA9YkufkaLjT6igF8ys9M2QttPZ8Ww0TxkIMjnCFkZo
         dCusvY0qxiigOB/dA2216js75+6dT68x2OqI+6ksiXImVZ5xRdW2qrGCZjABm0wU3qR2
         gUPbL8jm+/yG22XFdxu9LDxfnhENuIydOqataXeo8yFUj628sOf8VdibC0irTnkEXluY
         yduTT+xMNmcx8Ug1e19Y203PK5dSvg2x2yU101R8KrAuoU7j29X/a7TfFvs4MN/+lsC0
         BY14eZAFN698ri9Mp7O9wuWxgFLpSgr9Tn2p3M7YDK13MCb4ydjxjJkfX2QmrUPAG+TW
         9Vxg==
X-Gm-Message-State: ABy/qLbc07Ank3tBOXRxX4xDT9/JYMXvUNj1wO6vPpHBsL0Jv45ZGFPG
	ipcia1PQXQcvZx8ohFu2wc0hkpZPmPY=
X-Google-Smtp-Source: APBJJlFrKWzWT1bE9ktnKJNYQ8ZobbTzPhXm87AcZ0WUYzvazZJ8JGQ2YHS2UHIhfZ7eFReKc0Tdrw==
X-Received: by 2002:a05:6214:1d0b:b0:630:21a6:bb5e with SMTP id e11-20020a0562141d0b00b0063021a6bb5emr4872875qvd.30.1688152704951;
        Fri, 30 Jun 2023 12:18:24 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/5] Initial refactor for hwsim frame processing
Date: Fri, 30 Jun 2023 12:18:07 -0700
Message-Id: <20230630191812.2884637-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wanted to put this out there just as an idea before I get too
invested in extending it. The code itself needs cleanup (explained
later) but I wanted some feedback on the general idea.

Eventually I'd like to extend this to support remote communication
with multiple hwsim instances, e.g. via a multicast socket. As a
starting point the rules code fit nicely as a frame processing
module.

Cleanup:
 - Find solution for the IWD_MODULE_DEPENDS issue
 - Add getters for radio/interface info objects, possibly
   for hwsim_frame too rather than everything exposed in
   hwsim.h.
 - The hwsim_frame cleanup in rules needs to be changed. Prior
   hwsim_frame_unref() would send tx_info but now this needs
   to be handled in rules.c. Currently we peek into the refcount
   and see if it will be destroyed on unref, and send tx_info
   then.

The dbus dependency patches by themselves are actually useful so
feel free to merge those if they look ok. If you don't like the
preprocessor define thats fine, its a minimal amount of code
duplicated between iwd/hwsim so its not _that_ bad as it stands
today.

Note: These were done on top of the ADD/DEL mac changes so if
they don't apply that is likely the issue. Again, just looking
for a yay or nay on this concept.

James Prestwood (5):
  dbus: remove dependency on agent
  dbus: remove iwd.h dependency
  hwsim: use dbus.c module
  hwsim: refactor rules processing into separate file
  module: temporary hack to allow for no module dependencies

 Makefile.am   |    9 +-
 src/agent.c   |   12 +-
 src/agent.h   |    2 -
 src/dbus.c    |   43 +-
 src/dbus.h    |    4 +
 src/module.c  |    6 +
 tools/hwsim.c | 1115 +++----------------------------------------------
 tools/hwsim.h |   99 +++++
 tools/rules.c | 1017 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1224 insertions(+), 1083 deletions(-)
 create mode 100644 tools/hwsim.h
 create mode 100644 tools/rules.c

-- 
2.25.1

