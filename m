Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC297C
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 23:42:15 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id a11so24108357ljb.5
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 16:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4Xaol5z6RsPM+kLPrN31lOM6931lc7V1IyAy8eUeAs=;
        b=XcpjPXga3rKpp+IcvMxb8ZoSE2foQp1BKIoyiAFXVJgdjzvUHCiyvhldoah9SP7Ocn
         e3xf7ny3MwnByOZdBBRz6B+IbS5ZY/S7XQIvju6moX0J4jQkshFGj/tSQGk9BW6UjH1Q
         N0fjyTVqfMKrMDzPQV5pyOsC6O336bvaQPWnowAx1RGNT6vjOF0bycv/uRguC5wzCWLS
         8S+tUGxPJfWNUKagQSj97wmXkeliHWAzSDQEBhcwzDyabrkWzJmZKIaN6SgypUNGYSGg
         qUI+DBLvghKdMzbB31RyqyM+q5AElWmlHu3qU06fPrkwjrfpaXgtPtNm6wzwtss79lO2
         R0cg==
X-Gm-Message-State: AJIora/GuyPaLaPZVYe9YQaQSK8dPUedfqy8/neDGL1vYjtxrgUPPrQT
	br1ukicFOP8cwItYGp8QT2+jMF7avHySOFSa
X-Google-Smtp-Source: AGRyM1vos2PCd4lJHCXTrrEDYoHSdaNwd/qCHOYyx3+6U8LyvalGeQxgE1rlGexmPgwhIqTwa7S1ow==
X-Received: by 2002:a2e:bc1d:0:b0:25b:9667:87b9 with SMTP id b29-20020a2ebc1d000000b0025b966787b9mr286154ljf.91.1657237333404;
        Thu, 07 Jul 2022 16:42:13 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24250000000b00478fe690207sm7065388lfl.286.2022.07.07.16.42.13
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 16:42:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id e20so4940472lfq.11
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 16:42:13 -0700 (PDT)
X-Received: by 2002:a05:6512:1594:b0:481:6ea:3244 with SMTP id
 bp20-20020a056512159400b0048106ea3244mr451536lfb.300.1657237332985; Thu, 07
 Jul 2022 16:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
 <444493cc8338b6b8ac9e0a0a3149ea3ef55fd76f.camel@gmail.com>
 <CAOq732KGfw5_JkjDh09W0Jp6CfcECLweifFCEY1iCAXZ6kX+Lw@mail.gmail.com> <fc33625c8f1531df696fbc07099f16e71f7b4a86.camel@gmail.com>
In-Reply-To: <fc33625c8f1531df696fbc07099f16e71f7b4a86.camel@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Fri, 8 Jul 2022 01:42:01 +0200
X-Gmail-Original-Message-ID: <CAOq732+PeP4fxCUoYFG0MJK5sX8jAvBE8ZSJGfQVJPRNCLnuag@mail.gmail.com>
Message-ID: <CAOq732+PeP4fxCUoYFG0MJK5sX8jAvBE8ZSJGfQVJPRNCLnuag@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] test-runner: Support running hostapd in namespaces
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Jul 2022 at 01:19, James Prestwood <prestwoj@gmail.com> wrote:
> > > Since create_interface() is the only function that needs the
> > > namespace
> > > couldn't we remove set_namespace entirely and just pass the
> > > namespace
> > > name into create_interface?
> >
> > So set_namespace() also moves the radio to the right namespace.  We
> > need this for radios used by both hostapd and IWD, where we don't use
> > create_interface().
> >
> > I also think it's nice if you can obtain the namespace reference from
> > `radio.ns` or `interface.ns`, say, in autotests/util/*.py code or
> > elsewhere.
>
>
> Are there situations where hostapd and IWD share a radio?

Sorry, I meant set_namespace() may be used by tools/utils.py whether
this is an IWD radio or a hostapd radio.  create_interface() on the
other hand is only needed for hostapd so we can't replace one with the
other.

>
> But I agree, its nice knowing what namespace a radio/interface belongs
> to.
>
> >
> > >
> > > > +       def get_hapd_instance(self, config=None):
> > > > +               instances = [i for hapd in self.hostapd for i in
> > > > hapd.instances]
> > > > +
> > > > +               if config is None:
> > > > +                       return instances[0]
> > > > +
> > > > +               for hapd in instances:
> > > > +                       if hapd.config == config:
> > > > +                               return hapd
> > > > +
> > >
> > > Looks like this got carried over from that dropped patch?
> >
> > I use this in autotests/util/hostapd.py (patch 2/4) since ctx.hostapd
> > is now a list and to override the [] operator you'd need to subclass
> > the list and overall it's simpler this way.
>
>
> Sorry, I was confusing this with the HostapdCLI stuff. Nevermind.

(That code also used this method, you weren't wrong)

Best regards
