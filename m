Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39365C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:15:09 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-127ba06d03fso52828790fac.3
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pw77p8cR/musOHBBag8bIBvyKElomCSycx3io7RBOuo=;
        b=XeAJH+uiP/a+kHksOzXjZKOMb1TwPdYKjFSSbZVguAzf+cNSViu8FGYjQgN5hAADeq
         C7jSMQ+76yFeTXIEGjWIJQSxLGuFfQG0TOs77Iz2q3dgr706JH/WRUQaJTKe8qpyCoXX
         TQYrgT6QY3aUzyHxRDwGWqKamp+N9mMBPba1i0g4ZFD19zAAUhVYokI3ptaTnVgur15n
         OYNomVU0GZvpLv+gVWlIT2u/yNqpEeQDUcal9M7hmYkGolSKa19ugwQR81cfBYrLJVqw
         fvk76/HjPfZTbVXENpCugmMuaxaTN13jqOvyt5VIkfhzGsbJEKBAp2qjCuACtlX4mZ5+
         ZjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pw77p8cR/musOHBBag8bIBvyKElomCSycx3io7RBOuo=;
        b=J462WMBc5/bwnvn9TUqQfCopnreQTxDVZMvqlnNIGML79saRlxAuSjLZDPjrU0I/i+
         wd4uwDjStJOneKvOypxUqPSr1pS0+84chNryqFK5i2v44atKrW8uyolih3xu7lrm2HWH
         4SIOpD+kSy52YrPy+DxeYmSCNejAt7vS7J1OfQj1fDAfabcv/wFW+xh3OhzpzFxCsG0d
         jqB8hYGtWp1zAy68sjOgFVojHOP2qsDrkldc6LD7p5TwzSAIdZYX78v8soYEkv5OKWOe
         6mIBSiuj0LMYGpJbLSK1AHWf2Or7Z9EANbKWMnJwfbS+sGg2l3Gab1D/BRr+FhB2uG3I
         TzfA==
X-Gm-Message-State: ACrzQf2ymqJ1bKWxeYZGCu0+2gyYCmLbzPPtaiPcwZ4hIfHyR36IGGk6
	ipW0gVtHwOS71LancGJx4s4=
X-Google-Smtp-Source: AMsMyM5/3pCbxRCWUcQLq99x0UTnixACI+BcgInt2DYBLrloeAhl8ONuKP/54FUZ/xi95ahuAJUNdA==
X-Received: by 2002:a05:6870:5488:b0:127:7a3d:bf27 with SMTP id f8-20020a056870548800b001277a3dbf27mr3342150oan.101.1663344908910;
        Fri, 16 Sep 2022 09:15:08 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j26-20020a9d769a000000b006394756c04fsm10080562otl.0.2022.09.16.09.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:15:08 -0700 (PDT)
Message-ID: <7103b392-9757-1537-fd13-3b76ee21c919@gmail.com>
Date: Fri, 16 Sep 2022 11:04:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/14] frame-xchg: add type to frame_xchg_prefix
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220915220741.1128728-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/15/22 17:07, James Prestwood wrote:
> All uses of frame-xchg were for action frames, and the frame type
> was hard coded. Soon other frame types will be needed so the type
> must now be specified in the frame_xchg_prefix structure.
> ---
>   src/anqp.c       | 1 +
>   src/frame-xchg.c | 2 +-
>   src/frame-xchg.h | 1 +
>   src/p2p.c        | 4 ++++
>   4 files changed, 7 insertions(+), 1 deletion(-)
> 

Patch 1-2 applied, thanks.

Regards,
-Denis

