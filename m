Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470886643
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:14:07 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id l7so19353829ljj.4
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB2zGam2Stn3EF28WjxAxQs3CB6BJ5/3CUkKYJtO5ls=;
        b=IX9CjN9Wy3XSodlbmMs38Yh/Bh0xMVcPn1UWhGyJAHfXRDRj6w8CJsLa9vC2klZ5ti
         02hcJE8CR47RGKCJMc8J5UGlm6FcG0pUpRMYJh7RLyeKuTeurRv198N6+FgDvYQkZEGY
         1NqdEXwgC/jHxicV86Rk6oK3XjyigTed7zpiAJspsNnbW88KiMOz9vfDbt3MOi00DBb2
         KTXHxTSNE1foAT7oie7Am8rQ5m2kddMWnnIGIFblJYFVNPTyZpX3HjTWXa4gAjD3HO7e
         gMvipKr6+Z6s689NUzItFqo4VruhrQl/1QFHJWGD4wt6sQ7vcRT+T1YmCCEuZ7fnApAL
         ZS9Q==
X-Gm-Message-State: AJIora8jWCQbSam4cJsMDTAizN3is3eD+6keGw6WQzq1xQVH8wMC1kTh
	mIL3Fx14YdeiIkQmuo76TU4HpX5rjneZhekn
X-Google-Smtp-Source: AGRyM1vTEwoNvKyFbmpsFK+vZVDG+occqn12TqUt5xX36bDTZfESBqFZL8Q8B1LMHqdfnY6U1rIN0Q==
X-Received: by 2002:a2e:9119:0:b0:25b:ce6b:1a6 with SMTP id m25-20020a2e9119000000b0025bce6b01a6mr2137088ljg.433.1657145645007;
        Wed, 06 Jul 2022 15:14:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z9-20020a19f709000000b004867c6b0d70sm485580lfe.254.2022.07.06.15.14.04
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 15:14:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c15so20159658ljr.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:14:04 -0700 (PDT)
X-Received: by 2002:a2e:8681:0:b0:251:fd91:41a with SMTP id
 l1-20020a2e8681000000b00251fd91041amr24561103lji.216.1657145644574; Wed, 06
 Jul 2022 15:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
 <20220706165702.3241756-4-andrew.zaborowski@intel.com> <9427ce8032e264ecac49ac448b4fc0a29726781d.camel@gmail.com>
In-Reply-To: <9427ce8032e264ecac49ac448b4fc0a29726781d.camel@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 7 Jul 2022 00:13:53 +0200
X-Gmail-Original-Message-ID: <CAOq732KaeZqGyUKnaHm70qsyqNqktufkv4f2Vx-gu9znV6Nwyw@mail.gmail.com>
Message-ID: <CAOq732KaeZqGyUKnaHm70qsyqNqktufkv4f2Vx-gu9znV6Nwyw@mail.gmail.com>
Subject: Re: [PATCH 4/5] autotests: Reuse HostapdCLI objects
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James!

On Wed, 6 Jul 2022 at 19:52, James Prestwood <prestwoj@gmail.com> wrote:
> On Wed, 2022-07-06 at 18:57 +0200, Andrew Zaborowski wrote:
> > TestContext.start_hostapd() in tools/run-tests already creates
> > HostapdCLI objects for every interface assigned to hostapd, try not to
> > create new HostapdCLI instances for those interfaces in each test.
> > ---
>
> <snip>
>
> So I very well could have done it wrong in the first place, but the
> HostapdCLI class itself should handle this inside __new__().

Ok, that's pretty cool, I didn't know that was even possible.  Please
just ignore this patch then.

Best regards
