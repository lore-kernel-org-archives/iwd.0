Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78642561
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 23:05:19 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10c0119dd16so34040080fac.6
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SRoZYG1C0mblqgdR61CVWUbTgxYVOBwpfH7CEb1yYlk=;
        b=pwV/rxwoX1PxRRe8iQFyKUMJY/gmNxLKmfPDiCgD151I78EfYPQbzkeckf5AE3H3hQ
         FQ9UicEtEdpdnSI5RgtSiuXc8UYXqLrBteF5vCqajOkg+kdjpqnOI2n4FP41j2U15e2O
         fn4br0c5J5OyY/D4WgNwnY0UOVF8LoyxYgdTl+v1hHGzYcQ5OFHn+mD/Xa+LePio9E+4
         TDa+svxjxSveADI6J8igt5hcAdzVSTK1MTRA1/fjWRQ4xI1iFYz/DKCzUYYTtLLLjtAq
         OGz/4odtnTx6rp4DYqG0iKvU5luNQYitjpLzV8GstFzs/6NmjU2Othb61JeR5milZ6OL
         d4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SRoZYG1C0mblqgdR61CVWUbTgxYVOBwpfH7CEb1yYlk=;
        b=Ew7f7g3D/fecS9kSWNBEK/yDr8iBnGctFiUuFj3331w2Cb5ws1IxqG/UyaHrXpXcdd
         XJlfeg7NvtuYhKeeq4SL1eYYIN/GUfny+tIrFZVCunv2jqNVoLmmJMPY8QnNGOB7EBrj
         zEZRuF9iV2o1HbgeJThSsSvQnRx30WtZS1AMT4w0N9mPLj8GQtWln9qlTU5X10KTuYb8
         mCedOXVOODgrKzc6jb2GzBKAMym0vlumEXvObgTes1Duf9EEbAj+HN/GGZVC2tG3ntwJ
         3FA8b/yAS9dO6PcDOVHoPzroQ9wqXJaTFJU/Dz86vewo94wrEr1VGVgbOFJUX9llKp9u
         Cmjw==
X-Gm-Message-State: AJIora9gq4GinlN7Npn97YySH4jvf1BWXNHB0IKQTIqzPqR76AoKPBuh
	jqLrwWWrWl9wLMcxdnauGtA=
X-Google-Smtp-Source: AGRyM1uAFsf74WMWXaxbLpX9amTtwWM4wWoapFJT0yxscIfu5wvmooylVbLhjLFSQZUDYGRWQC9dMA==
X-Received: by 2002:a05:6870:4286:b0:10c:326a:27a with SMTP id y6-20020a056870428600b0010c326a027amr975754oah.259.1658271918695;
        Tue, 19 Jul 2022 16:05:18 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id l20-20020a4ae2d4000000b00435b646f160sm682518oot.5.2022.07.19.16.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 16:05:18 -0700 (PDT)
Message-ID: <bf381f0b-06a9-0c0e-5bca-8157d8d35aba@gmail.com>
Date: Tue, 19 Jul 2022 17:45:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] unit: memset band to zero after alloc
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220719222950.540619-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220719222950.540619-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/19/22 17:29, James Prestwood wrote:
> In test-band the band object was allocated using l_malloc, but not
> memset to zero. This will cause problems if allocated pointers are
> included in struct band once band is freed.
> ---
>   unit/test-band.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

