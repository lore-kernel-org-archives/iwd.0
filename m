Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F811C26
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:27:01 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id j22so14613139ljg.0
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVkbXZvryI6cP8/KSssRDs4+P07NpL9abutyewbIzt8=;
        b=2/mf+VTrogZfxJprKlwEsxw2Uf9LhgCRcgE+ciXKU8gFWBakGIY4n0Z76bxoJtmlHE
         XEu4tfgJI9uhdTz41uk4sdagFvnppN2654qkseqNLSfD4aQ6hw4jwiwya8uYr9K/X8UN
         QeI1ZL3A9Ml/A189nWq9EISuAqc2aL4fxvgSpzS2vZfh7xJ6BbbSpfNJNt5Iipw1/huG
         ahWg4ZdWh82a9sQQZh+NmkPI/JRpQ3vDPeVKO1ckuRR7x8eWHczB1T8U+kFttiKAUP1v
         rCmWoHfM5Tl8881drVZVAtQs2d6WIcTZoJhPeE/lICnvc12hs7ncXzyXp0e/+B3RH4c9
         WlvQ==
X-Gm-Message-State: AJIora8YjzxTn6FJMfxoRqkmjJU+HHxaLp4oK1qi1+9EpItjbcLBfUK3
	YKIoW65mIkBhZ44iWc6AETMGJHMiEHRLgA==
X-Google-Smtp-Source: AGRyM1ssa3VsblggOx44IK+0SwzW8hXmnlJG8rOgkTJVcx/JvmrNnlx/cbq12wkjeZB2n7Jy6oeiGA==
X-Received: by 2002:a05:651c:1503:b0:24c:81df:e1f2 with SMTP id e3-20020a05651c150300b0024c81dfe1f2mr3200835ljf.182.1655940419282;
        Wed, 22 Jun 2022 16:26:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a199209000000b0047da6e495b1sm2727599lfd.4.2022.06.22.16.26.58
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:26:58 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c4so30339518lfj.12
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:26:58 -0700 (PDT)
X-Received: by 2002:a05:6512:401d:b0:47f:654d:e48d with SMTP id
 br29-20020a056512401d00b0047f654de48dmr3628090lfb.359.1655940418281; Wed, 22
 Jun 2022 16:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-14-andrew.zaborowski@intel.com> <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
 <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com> <51dc9302-29e1-134c-7358-65ebdaae4db9@gmail.com>
In-Reply-To: <51dc9302-29e1-134c-7358-65ebdaae4db9@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 23 Jun 2022 01:26:46 +0200
X-Gmail-Original-Message-ID: <CAOq732Japcdcb2Y-j4KgtDV1Vb2ciwW2AEJCRCzzfvCn1KKJRQ@mail.gmail.com>
Message-ID: <CAOq732Japcdcb2Y-j4KgtDV1Vb2ciwW2AEJCRCzzfvCn1KKJRQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] autotests: Add bad netconfig settings scenario
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Wed, 22 Jun 2022 at 23:02, Denis Kenzior <denkenz@gmail.com> wrote:
> On 6/21/22 16:17, Andrew Zaborowski wrote:
> > On Tue, 21 Jun 2022 at 23:04, James Prestwood <prestwoj@gmail.com> wrote:
> >> Does this happen to depend on patch 13/15? I applied all the other
> >> autotest changes but this one fails to pass testNetconfig. The
> >> assertRaises() call is what fails for me.
> >
> > It does, sorry I didn't make this clear.  Both 14 and 15 depend on 13/15.
> >
>
> Can this test be made applicable to the current netconfig implementation?  In
> other words, does it really need to depend on patch 13?  Same with 15?

Since this tests things that are fixed by switching to l_netconfig,
the test doesn't need any changes but src/netconfig.c does (that's
what patch 13 does), but it's safe to hold on with this.

Best regards
