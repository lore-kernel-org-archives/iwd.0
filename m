Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D9441A
	for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 14:17:44 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id q5so1924463plr.11
        for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbKhOuyRnt/61QH9p/iv4tWBidAdq7fluyqyhXzF2p8=;
        b=iRrAJWcaWodEbbg5NFb931t+moWM3ZeuHDSNigrO69jGWXCPOpwI02IVUG639mtiAW
         1ig50sjNcTnK9b6xsVVhTXk9HA6MQ75Ct6zW555JaIJUI14ty1CMGAadXpILi7OZ1A+s
         1jzciCIrjZKIO9NROEWFHrK4Gaw8vAW/rmjUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbKhOuyRnt/61QH9p/iv4tWBidAdq7fluyqyhXzF2p8=;
        b=thak8XiCHR5xqxcWBhVlXwcZmBkhMOM9IfvPuitwo1ySm5lvgXNTPwSTjhsuLc8WOf
         yPIaj+HvtCMPtdbuOmY5FQVoLRDluU4R1xkjBPRsv08gz3/ZU548qJeY1nPub8tGoJzs
         k4KYjeEMaKlikVHlUZ6Obs2vtMqjFZkuDlSrB4KsAIwUqByUxA9ulxBh/If5hk0t2lHZ
         hF0uoEt9tiI1HgqLTDBkBt6JJT9IOa+3Z9/YscGhmC2N1Yvvmcm9lTVqcPYDS6tKUB50
         uTtuXpbGcg9gJAx4Xx83YGy3iNk+QBoKouH8jOwCBr1t1Fl2xGmNzEfy4RmckSnN0yL1
         FABg==
X-Gm-Message-State: AJIora+lQa6nbZJ3KL7Lq5xKcfajnoanVp55XU7gCxHhX+ek8Hk3SrCu
	uvY7AhG7PH9Nc1IDoDV7P+p7YzggMBVL4ydUeS52LQ==
X-Google-Smtp-Source: AGRyM1s+dzkw5Asi6j2pqnYkeLoH0yM2bNqyOI2JSM493B+l1+8BigI+wMho/a+icb0sgXLfhCTbIR1MZ9bhvBAlqtU=
X-Received: by 2002:a17:90b:4387:b0:1f1:f944:16f3 with SMTP id
 in7-20020a17090b438700b001f1f94416f3mr11859569pjb.118.1658413063532; Thu, 21
 Jul 2022 07:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220721021314.14066-1-denkenz@gmail.com> <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
 <daab977b-fdf1-274b-0ebd-45d71b090500@gmail.com> <CAG17S_OysUm+YSDobUTLnY3k7mU86WMoVRY7D3iz7dFMBYYopg@mail.gmail.com>
 <f2c732a0-fb4d-c37b-b4c5-99006c1a9245@kvh.com>
In-Reply-To: <f2c732a0-fb4d-c37b-b4c5-99006c1a9245@kvh.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 21 Jul 2022 16:17:31 +0200
Message-ID: <CAOf5uw=byqhi9yZSGZMwGr+ZAwEknhhn2c4sgqXixFnO9-FfLQ@mail.gmail.com>
Subject: Re: [PATCH] tools: Add simple utility to generate the PSK
To: James Tavares <jtavares@kvh.com>
Cc: KeithG <ys3al35l@gmail.com>, Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Jul 21, 2022 at 3:39 PM James Tavares <jtavares@kvh.com> wrote:
>
> On 7/21/22 9:26 AM, KeithG wrote:
>
> > Interesting... Which arm distribution are you using?
>
> NXP (aka "Freescale") Linux kernel (based on kernel 5.10.9)
> Variscite Linux layer
> Yocto Gatesgarth
>
> Hardware is a DART-MX8M-PLUS SOM from Variscite with an NXP i.MX 8M Plus
> processor.
>
>
> Does anyone have a suggestion for a libkcapi-based test that help
> isolate kernel issue vs. iwd issue?
>
> I was looking at the kcapi-dgst tool but honest have gotten a little
> tripped up with it.

Can you try to disable caam?

Michael

>
> Regard,s
> James
>
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
