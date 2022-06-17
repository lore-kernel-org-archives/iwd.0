Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10820E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:13:09 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id v143so6428859oie.13
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nb/wa5kBy5Ue4P/aT88ZdPn4xKwDkwybvCobvGrQm3I=;
        b=JwhONLf4v5SEvq9zTXHCLpIG+mGsT8vul1Fxjkfs8igsJPo388IHzunw2Sg9Al5+oP
         MkZ8S3lWHQdZzu+c5tVG84+/N8Q03H18vtSUW6/trdsyOznz5GdqQMITahJfqvEYN+vJ
         L4GaT+3tt5vJ/31YhrTlVK/ZzP7q4fa0s/LE+vfISxEDumdpdoy4AJiZAST0yM9I0f5N
         NOj6luaCF/plOrmwwvU7zrckd/9KVnfPWlM1etWs1mb5tLwUgkyqX5vgtafSeM74RLOc
         WCrT67CKRa9i3eq8vHHQfIr8asVXtd9wMHlTdy3+Skx9YudMAzNO0HLkJ5UYoN6VU7xY
         RXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nb/wa5kBy5Ue4P/aT88ZdPn4xKwDkwybvCobvGrQm3I=;
        b=knF0BCjvfCZWO226eZgs6X9coo1Iq8+yHM8Oghygdi2zZ4pIlwML6v1Zz98sZET6ML
         UXHWVG7g3lkF5D6bpH/J0wGYZR5+OOG4yR5ZhhL/dgJCuY2ejHe/rB62nT5ClN3qMAVK
         6x041B13P7c9+Vvy2K/owIWAmtQTS7DgWdTEyNyLzon1FM49JFuR8z1VSIcusZHI6t7N
         NgDWzgYQ68JxfeIBtMdfEdsI2tsaeI9J3lsi+c8xukObFhMO5cL6ZEj9V+42LJSxsTXD
         Qia5Rtd2a43esKO6gRm7NCto/tG6D9kr9IrpEquH942sC+nUEvVGAKwe+eTBa1Awdy5f
         cmPg==
X-Gm-Message-State: AJIora9H+St7FkmYy6DniU0kcPDlXMnPQVNc9Af5MvVn9t8E3T2dXJRn
	6a0eYsSIVEiLt4/bnPeInqR/5hkuCvsL4zuQ
X-Google-Smtp-Source: AGRyM1tacNkHOKi1LBNH+uBgX1B++Ha1FdQGZ7nm8SI+W9l8+B/36E3Kt45oRmHG4VPLyVm9UF7JAw==
X-Received: by 2002:a05:6808:307:b0:32e:fe57:b762 with SMTP id i7-20020a056808030700b0032efe57b762mr5783468oie.281.1655493188679;
        Fri, 17 Jun 2022 12:13:08 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s24-20020a4adb98000000b0035eb4e5a6b2sm3054249oou.8.2022.06.17.12.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:13:08 -0700 (PDT)
Message-ID: <589b0562-12df-e378-c63c-5e24b5378a00@gmail.com>
Date: Fri, 17 Jun 2022 14:09:49 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/15] storage: Log a message on network file parse errors
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Most users of storage_network_open don't log errors when the function
> returns a NULL and fall back to defaults (empty l_settings).
> storage_network_open() itself only logs errors if the flie is encrypted.
> Now also log an error when l_settings_load_from_file() fails to help track
> down potential syntax errors.
> ---
>   src/storage.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Hmm, I'm still not sure logging l_errors inside storage.c is the right approach. 
  I see this crept in when encrypted profiles were merged.

Anyway, I went ahead and applied this, but I wonder if we need to fix this to 
return proper error codes at some point.

Applied, thanks.

Regards,
-Denis
