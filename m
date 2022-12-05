Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE466112
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 16:19:56 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3b5d9050e48so123638937b3.2
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9oqrMrNvuEgxe59D6AjtaeyWVaTWZ3wfXgcNhIECaz0=;
        b=pkarLsGG6z4rpoBiHwpoIGaIJEkKs5WiahmBI1rhqLWNlA8q4OiKNh5k21ufnIk4cU
         nwSECo8XsY3TC8CATZJRvhU6l7RRqb51YBkqwiKCyHNRpoKbZqC/2e84ZZnfd+OsLPCI
         3Iu91ZKERI9ToUxZ7avUlXU1vjkwuCrKrot4rmP0vt8ThVrkYghAWMVxLu+iBygNwk2Y
         Kb5fVatjGhk4UtcpzYsTgHX+6Yc+sX2xCCds1O2dmzcYnKbe/HGBBmJzul6CvfV8x5/1
         raT/33EZ+EGxR8HNBlfb4ISr3hIZRAPksJ8B26bA54QcD6g+R2oT+b6qwYh4Du+2VbGZ
         R2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oqrMrNvuEgxe59D6AjtaeyWVaTWZ3wfXgcNhIECaz0=;
        b=10exHmvgMBZKROLHoRl7wpNkWoP09PX+dcodgOIiiWie1bIoDIJ4hqlyIzNdjtg3XI
         myVtpI1xBP7o6LQ0piWVXKjz++Bg1CRiLN/nWandWRAAXTSAKGJ0NkWTPJHblfgK3iqL
         ieV9rUs5CD/3Bhld8b8wmDkQiR/VldnMAm4ecCk78GE3mcwonsuTREAxtKCOaJN4Kq06
         JqQcRUAQH/d3YNOk+1yO7oWkb7dFiSbbilXxiy84rNvlVjD2INlUpdqWYH3k1aaimCBb
         zyx4yuMyvwckhUaC3DkU075clUcXno5uMkTKfDKW+vEeMq3mzEGiRenFooAzabZAIq3V
         6RXw==
X-Gm-Message-State: ANoB5plhCvL8lmAQ+Cx1J/somSAo3k5a6danuH7RsmXFuEAVfmy6f0Tl
	TiBYHz7Kw9k8vyquJERozUNT5jpiIpQtnFfsQA+TWJhWUkM=
X-Google-Smtp-Source: AA0mqf6ZJdxV2JWaTkHFEL4G3PhBXKgDRww0n+DOAun0ZBXevFENIanyp2EYOdZ1FRRPZnZ9aLDEEFSY0+gY9H1vyhU=
X-Received: by 2002:a81:2501:0:b0:3cc:8ab:be2c with SMTP id
 l1-20020a812501000000b003cc08abbe2cmr32185135ywl.205.1670257195475; Mon, 05
 Dec 2022 08:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 5 Dec 2022 16:19:44 +0000
Message-ID: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
Subject: WPA3 SAE passphrase limitation
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greetings list,

I was playing around with a router using WPA3 Personal (only) +
CCMP-128 (AES) and noticed something odd. Namely: the 8 character
limitation imposed by WPA2 is enforced with WPA3/SAE.

Whenever I try to use such a passphrase (via iwctl) I get an error
"Argument format is invalid".

I realise it's not the best practice but the exact same router just
works with my Android Pixel phone.

Would anyone be interested in fixing this bug? Alternatively any
pointers where the validation happens would be appreciated.

Thanks in advance,
Emil
