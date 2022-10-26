Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CBAD32
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 19:53:54 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13bd2aea61bso10874617fac.0
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2UZJRU+McZqQnW4B8pHvtWIoNUsPk78mkssf9+74Tc=;
        b=dglzHFhpGYFICePtVNpTbh1jbEC2t8E0x4c9A4F+l4DKu7JjExoDHvZkbZiTmVG7z5
         M49tjSZaDSPYdBnASsROKIzNHOLE9IhCC3xnpcIo/fmVHi2KtEDn5Z6Kj/QV2jvPVwkB
         xCYP2y+l1bXeambSDyMvm5y/1HNYthAUctzgivlmIYm+1Wh3IktvzWSqqiMq4b52yO/I
         P55f4PTRGalPmCRehYnlwwGM0OJQNaHW0ih8EZRmtjQjXA27UNGuQcywdBNNjtfP+feS
         4sA02KvueZigZfp3INGhuE9FwyFAYbjxbSLJXdQk5j+5OsXLXQOB9NncYfwrFVtJEYO8
         l69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2UZJRU+McZqQnW4B8pHvtWIoNUsPk78mkssf9+74Tc=;
        b=0SCH4GVkdZOoKRVmoD0sm+yJ3Lh5k8QbCG2U95oUNjWHPRtS92qvd+eYupfdIzcFxN
         nCa+9ryZU/Ou2BvNI5A/HcZLpfjtYUtiq1ADCrIZNO8GrvF18jqB79rhg/0oRVNJiQy5
         DDbNUzRCHxG0cdcGchQzN1G3dXq3pWj8oKbRVrNrQNudlpyKqvfnypFFI/1mQd4v+jNT
         5vh8s6Z6YPImWuIIyTCXHo88JYGvQnh3NNK8LJAx4o2hAUNdpZuC3fPxTkgkieitcW4r
         q/Vj2I83vKFKB01ZNxbAUA+cKpheNWOhLb3BIE1SmmkoxbVNfSt//lkzJse8sIgiiLOU
         8o7A==
X-Gm-Message-State: ACrzQf1QsHuIZEnBTfah7LKECI+szX1Jv+5vM/HgahM59pnAEx0moLls
	J6UwuHxC9bUHVY98VJOBde7R4zPaK8o=
X-Google-Smtp-Source: AMsMyM5DviIj+6o7xJLsDksr8ozQUY/qIP5UBLpClhkHl410MHgVUq3kDBjhvSEjJurnc6QpzkfVJQ==
X-Received: by 2002:a05:6870:a70a:b0:13c:19bc:12ae with SMTP id g10-20020a056870a70a00b0013c19bc12aemr2853489oam.240.1666814032479;
        Wed, 26 Oct 2022 12:53:52 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n128-20020acabd86000000b0034d8abf42f1sm2370462oif.23.2022.10.26.12.53.51
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:53:51 -0700 (PDT)
Message-ID: <2ca339a8-0908-2334-285a-d08b51eb2d4b@gmail.com>
Date: Wed, 26 Oct 2022 14:53:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/26] eapol: More strictly validate
 key_descriptor_version
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20221021191307.31492-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All 26 applied.

Regards,
-Denis

