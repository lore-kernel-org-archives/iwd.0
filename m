Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98A6646
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:15 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id f39so28179353lfv.3
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+gGhStbas+FF0WxhTm6wCOXOkaSRHkFtyMzH0HsPbA=;
        b=eIwLgAy4f1BaDVP4f+PhCQ8eEtOeqVdqzsObko7nR0ASUpSp4iuWr4vRdJ+0qw2VQP
         mU3wDmS2wj3wyTSDVrJl8a+1SqYBokL/Z/Aic3QmHzRoJP3b7269SKbCFq7Q7EnMDiAW
         UocT3edb7XI12tpq6r4/nJw1Ln59yp5+EnZV4A8Viw/9DP+3CLEIiijD8FFXtOvjL1dG
         J90dff4aLe5WK//g+cxN2ZRlaHtZ+X56npAyGI2LsKYXBzxGwOuHH+XZJP3Z0NPzw8hg
         zjHzeSxXQJrgjgyOW0NtBuMrGTNM2csGuSpbj3mvev07AnQkGVB9R6hwrzwZLk4WODs4
         v7uQ==
X-Gm-Message-State: AJIora8faIIUHa/9R/iytb7pMurtxn5AVCli61SyF7s5lBpnd6+nTcso
	apJGbIKZ/BxQkiXYuYUcDIUEp6hE6+c4OpIN
X-Google-Smtp-Source: AGRyM1vvVDUwu+8XGbFGj2r/p4i4tnGlpztPvU+pVacjM79uqRaCobxfH96ju9Rnb3CjkQV2A9mytQ==
X-Received: by 2002:a05:6512:3f12:b0:47f:51de:d067 with SMTP id y18-20020a0565123f1200b0047f51ded067mr26971547lfa.146.1657146073687;
        Wed, 06 Jul 2022 15:21:13 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c9-20020a056512324900b00478f2325fbbsm6458484lfr.282.2022.07.06.15.21.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 15:21:13 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bf9so4929798lfb.13
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:12 -0700 (PDT)
X-Received: by 2002:a05:6512:2311:b0:47f:6f75:6ea8 with SMTP id
 o17-20020a056512231100b0047f6f756ea8mr30176679lfu.517.1657146072778; Wed, 06
 Jul 2022 15:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com> <284b6456a09905fe55486f9a829f5fc84ac3cf39.camel@gmail.com>
In-Reply-To: <284b6456a09905fe55486f9a829f5fc84ac3cf39.camel@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 7 Jul 2022 00:21:01 +0200
X-Gmail-Original-Message-ID: <CAOq732+nnfr=FNu76-cd+LHEPgEUZgEDJxRMBhP7VvpssDb+MA@mail.gmail.com>
Message-ID: <CAOq732+nnfr=FNu76-cd+LHEPgEUZgEDJxRMBhP7VvpssDb+MA@mail.gmail.com>
Subject: Re: [PATCH 1/5] test-runner: Support running hostapd in namespaces
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Jul 2022 at 19:57, James Prestwood <prestwoj@gmail.com> wrote:
> Looks like this broke testEAD (or at least this is the most likely
> patch). gitlint also wasn't happy but to be fair I just copied the
> bluez config so I may need to take a look at that.
>
> https://patchwork.kernel.org/project/iwd/patch/20220706165702.3241756-1-andrew.zaborowski@intel.com/
>
> I'll go ahead and add you to the maintainers list so you get the CI
> notifications.

Thanks.  Honestly I was planning on looking at the CI results and
acting on failures.  Locally I could only test that the commit was
causing no new failures and testEAD was among the 6 already-failing
tests in my setup.  I'll take a look at the results now.

Best regards
