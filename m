Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F349A3F
	for <iwd@lists.linux.dev>; Wed,  1 Mar 2023 03:26:40 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id v11so9084173plz.8
        for <iwd@lists.linux.dev>; Tue, 28 Feb 2023 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677641199;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+OnT+TZTsMCfvpDedSLKkXVcIn47cCZHmz3DuwrI0xI=;
        b=Y7FJ78q9qDo1aATGSc3SNNHDjFAX7SilZs5ltlJgD+tO4C99bYwfa1+91txyIHZwiA
         roTwompTvn458T/wkxuxHMaA+AOYBgwZufmV5nWHIQ7Cy8pxbuPNXgPKSLeAh1pbfMsT
         vKcdsX8X68ithQ9c8dVZt5moEvwM3NEUs2AQWDNcX0GxNHl7dyocED8eAkGwLfmFQ1YP
         jvMxoWqmwCCUrfa5aGp5GRidnnssWawJZU5zJKiomKQsSkvGBQGIQqqH4mo11Pn0bmYj
         n0mG4CTC4RHywEb4hIBDTp/6FcOEduNqlXiUd/ZFGVIbd0SGY3pZ1Sf/AW8ZmNWC7vLN
         YvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677641199;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OnT+TZTsMCfvpDedSLKkXVcIn47cCZHmz3DuwrI0xI=;
        b=h3/B/mL2zyFd1AmOMpOB55DFCtQGraMuvToitwd8T/iFH6eyYewkdjjRz+ba433vDS
         xIVTtOsZv3tcb9davAcCFL5yFnbu1SzvVh5pJzwLrqGYEmdq3CJci8Uf6KWRpIi69av1
         LkJBn+nXSY4YO0aiUD2GoxWWUg6jUyReDhkClLP5Tz8l7NODyGBDKU2X6gAiQvaQSOWs
         03NdJwK+KIc9W0L8PVzigP+Bpek1uNGMPaLAwq+3X3MEbsICs/ZkYP9TJCNNHw8hobfd
         jC01iww4jfZZxRBvZm+a6z0WOJT4P77q2QQ3GCB5XEMkOwvCMAHcHkLgKhwqSGm5dZTu
         dQKA==
X-Gm-Message-State: AO0yUKUyH/UVyEt//OkDfHV189uacDk226kZflnQuR62Pvl2tSTKfg+F
	2pn2nFp6jpGCcrJWgurdqnBjPCJOwEk4QuVbe+AWy20Jixo=
X-Google-Smtp-Source: AK7set9EQ1//H2PL3t/wFGhAGiWAifrO7vE/acTVE0st4Zk+ndZDOajpAh9o8llNtx5gx+F+pbxjp6n6ekwq9J2vHlU=
X-Received: by 2002:a17:902:efd4:b0:19b:636:b153 with SMTP id
 ja20-20020a170902efd400b0019b0636b153mr1800077plb.6.1677641199686; Tue, 28
 Feb 2023 19:26:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 28 Feb 2023 21:26:28 -0600
Message-ID: <CAG17S_OaL_VK9e-s=DbwwKOAdjX9jR_B9ogifs9Di1-VW=ksmQ@mail.gmail.com>
Subject: iwd ap mode changed?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am playing with ap mode and I previously used this page to set it up:
https://iwd.wiki.kernel.org/ap_mode
Now, when I use iwd 2.3, I get
"Operation failed"
when I use the iwctl ap start or start-profile command.
when I revert to version 1.28, it starts to work again.  Is there a
changed parameter in the main.conf or something that I do not have set
right?

Keith
