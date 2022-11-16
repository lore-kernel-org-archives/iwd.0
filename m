Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11997C
	for <iwd@lists.linux.dev>; Wed, 16 Nov 2022 02:04:18 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id k19so20001868lji.2
        for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 18:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFs67h1xzhHqzgnaSvEX9yc0Kig1oXBxljP06fveB2g=;
        b=jMpyzLqSjSSrONS5FmMAldJ66VIZWwXXJ86m6yHu+ChfG7q+CBpzS0o9l2UoWO4mLm
         Z2kil0RgMV5vp4X/+P07908vXB2roDUz5BOEdSZ0edUCT7Vi3nrE6HhdjbZ7S5Csdi4i
         Y2q+yY5ZGeamseBgQbU1dkVesU56nQ3viacQA/hN+qP5ru6wLrr0ESJfwdxRBrYTtLTU
         Gyzl30Q4E3glEo41ybx8/jSO8QKhq7J3SEATQWMNURLVdVXAMC5G1rEBAyQGQtjWLa4A
         AiuYjP49hpKqPavw4+OHQ1GIzom5a/Zf0f1ihtqN8aeyLWRAb/l9EJ4rtkKEHxG962Pa
         NrVw==
X-Gm-Message-State: ANoB5pmpm9nbJLahZliDwnnu/z+qJiH084gjlSKhEhFagLCk87t8U9HA
	mrn6x+ccNlN6oHA1ogQCI4CNGashrjY9rw==
X-Google-Smtp-Source: AA0mqf5GewoekJM2qLFjdWJH3ZLRIJs9VT1ctQPVSD/oTe5jWlJIvjsmxd21SfBR4KWIlx2twP6XXw==
X-Received: by 2002:a2e:9a8b:0:b0:278:eef5:8d17 with SMTP id p11-20020a2e9a8b000000b00278eef58d17mr6233552lji.205.1668564256466;
        Tue, 15 Nov 2022 18:04:16 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512020a00b004a45f2e49b1sm2390115lfo.273.2022.11.15.18.04.15
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 18:04:15 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id c1so27328526lfi.7
        for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 18:04:15 -0800 (PST)
X-Received: by 2002:a05:6512:3194:b0:4b4:981a:6f9d with SMTP id
 i20-20020a056512319400b004b4981a6f9dmr3946399lfe.584.1668564255235; Tue, 15
 Nov 2022 18:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
 <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com> <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
 <c6bea4a7-4f4f-38f1-82ca-8db7d36a13f3@gmail.com>
In-Reply-To: <c6bea4a7-4f4f-38f1-82ca-8db7d36a13f3@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Wed, 16 Nov 2022 03:04:02 +0100
X-Gmail-Original-Message-ID: <CAOq732JNqRgfh1m8GyqviCNU=A9GtxK3NM8ecVDT6Nk+yHDWCw@mail.gmail.com>
Message-ID: <CAOq732JNqRgfh1m8GyqviCNU=A9GtxK3NM8ecVDT6Nk+yHDWCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] storage: Maintain the tls session cache object
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Nov 2022 at 20:41, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/14/22 19:29, Andrew Zaborowski wrote:
> > On Mon, 14 Nov 2022 at 21:03, Denis Kenzior <denkenz@gmail.com> wrote:
> >> On 11/11/22 19:19, Andrew Zaborowski wrote:
> >>> Any
> >>> sessions saved in relation to a specific network (ESS) should use group
> >>> names ending in the storage_get_network_file_path encoding of the
> >>> network's SSID+security type, so that storage.c can automatically drop
> >>> these cache entries if the network is being forgotten.
> >>
> >> It seems overkill to encode the full path into the group name.  Perhaps a
> >> hex-encoded SSID is enough?
> >
> > It would be nice to include the security type, how about using the
> > file name without the rest of the path?
> >
>
> OK, but I'm still failing to understand why?

I didn't want to make this specific to 802.1x (from the commit
message: "While the use case is for eap-tls-common.c to call these,
the same cache
object could be used if l_tls is used in another part of IWD.")

>  TLS will only be ever relevant to
> 8021x.

As an example I can see things like connectivity checking needing tls
in some way.

>  You even hardcode 8021x security type in the EAP changes in patch 3 :)

That part is obviously specific to EAP, but storage.c not necessarily.

>
> The file isn't really user visible either.  No normal user would be opening
> it...  In my opinion just basing things on the SSID would be enough.

Ok.  Let's put "eap" in the filename.

>
> However, now that I think about this approach some more, I think it will fail
> for Hotspot networks.  Since removal of these won't be detected properly.

Ok, I wasn't really considering Hotspot so far.

> Actually, any removal triggered by the user won't work either since this path
> doesn't use storage_network_remove().

known_network_forget does call ops->remove which translates to
storage_network_remove for non-Hotspot networks.

>
> I think you need to hook into known_networks_remove() instead.
>
> >>> +     for (group = groups; *group; group++)
> >>> +             if ((group_len = strlen(*group)) > path_len &&
> >>
> >> Hmm, >= path_len?
> >
> > Ok, but using just the network's id as the group name wouldn't be a good idea.
> >
>
> Why not?  What is the additional "EAP-" prefix buying you:

To disambiguate between sessions saved by different places in IWD that
might use TLS, obviously this was based on the goal I mentioned above
that the cache not be limited to the EAP handshake.

Best regards
