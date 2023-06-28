Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A46FCC
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 23:19:41 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so115303e87.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994379; x=1690586379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaaIZ9jU6PiP3trTUxYxdvkCqdifUWCgZCop89555aU=;
        b=a0UZZkNkUVOzlmO3H90We3laDIh7bcGpmf7Xj404qUky+33x3hGHww67f+8QB+pgid
         zHyQSNIEXqyRGLj2IDroh/yYcTjvoU87yf1Ru+sjk9vzbzg6/RTiKrJ9Xm72TbhYblNV
         r/AxR04GE6ZB2crZU+0oquHab9YqZnnYNvhtbi6QEL+gR+53t/VGzJxU8Th0MBcLOk2R
         JxyIBxl+q05JjdAzyqNImq+oKuXEzvO34lI+UmDncnCuF+3XIDW5SfM4EmpV1tDFC1xe
         IfzgUchufPXJtYf7Heg2AooVW4i9tKiSe9IcI9YzUNOpPtPgUu80wgZ85bYjySAKVKU2
         C82A==
X-Gm-Message-State: AC+VfDw6txT/h5FavPLI1QT7NTAaEMIiMEoM7K1WXkZ2J4pVyv5qHB4I
	WVxeO0hmi5yatOcoHWXHuXBQ02nNm8vrkA==
X-Google-Smtp-Source: ACHHUZ7MzJvMP/qdXo7qV/MqRNYhYURvM+NCIWWmdCddASnUhhFkiz4w7FpVdEld8ReSjMkbiDA8kQ==
X-Received: by 2002:a19:4f52:0:b0:4f8:66e1:14e3 with SMTP id a18-20020a194f52000000b004f866e114e3mr18406151lfk.17.1687994378860;
        Wed, 28 Jun 2023 16:19:38 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d19-20020ac244d3000000b004f24ee39661sm2123307lfm.137.2023.06.28.16.19.37
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 16:19:37 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so1021291fa.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:19:37 -0700 (PDT)
X-Received: by 2002:a2e:9081:0:b0:2b6:a6c4:b848 with SMTP id
 l1-20020a2e9081000000b002b6a6c4b848mr6766982ljg.31.1687994377636; Wed, 28 Jun
 2023 16:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230504215247.581443-1-prestwoj@gmail.com> <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com> <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com> <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com> <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com> <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com> <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com> <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
 <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com> <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
In-Reply-To: <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 29 Jun 2023 01:19:25 +0200
X-Gmail-Original-Message-ID: <CAOq732Jy-7694fPsHc5ZOuGxxE_yx=-RnsegR0+DXE4UJsaBMw@mail.gmail.com>
Message-ID: <CAOq732Jy-7694fPsHc5ZOuGxxE_yx=-RnsegR0+DXE4UJsaBMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known MACs
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, 28 Jun 2023 at 18:14, James Prestwood <prestwoj@gmail.com> wrote:
> One other potential (but much more complex) solution would be to use
> multiple hwsim instances that communicate, making a sort of distributed
> hwsim environment. I'm working on a similar concept which could
> (partially) be upstreamed, at least the hwsim parts.

Another option would be to occasionally dump information about phys
and radios in all namespaces.  While this is complicated it may be a
little easier than having multiple hwsim instances because you can
move threads in a single process into network namespaces.  I.e. you
can, for example, share an l_queue between temporary threads each of
which moves into one network namespace, opens a netlink socket, dumps
the phy information and exits.  Or you can keep the threads alive to
track netlink events but locking becomes more complicated.

Best regards
