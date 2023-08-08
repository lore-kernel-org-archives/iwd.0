Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779F385
	for <iwd@lists.linux.dev>; Tue,  8 Aug 2023 04:59:48 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6b9e478e122so4349560a34.1
        for <iwd@lists.linux.dev>; Mon, 07 Aug 2023 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691470787; x=1692075587;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfD9GffLl9zYn1uFwSKz4hYH2fFeu2rgd+0cIrPxSrM=;
        b=kizUKK1LVoUK2enM/6gz6JFDbAEyC1wAoyByMiWWV5gheVcmW0FC9d6ISPs7ZWZEi4
         ZF7bBH5jVjK8PiXZQtoRYY2KJnER9O+d9LbyTrj1cwC6kfvsnBRtb8OUfRfrIuN7StJF
         EYq61HLw+6tEialT66HvhKzjhg4zLFaDflrqkn8UONyES0GcXaM9jWyKWr5pGHBWbIp1
         DE7DE44CrDxurWFBifNPF9KqcPSwtdoCo6zYdvo99LtcBxwPfKOVyk6VOJlMXLH2FHDb
         WddKdKPB6ue4UpMOe54AP/yxJUxGbWaQVBf+zCEC7sWux8UHNeZfoXU3iFFnBagbUNnz
         I2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691470787; x=1692075587;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfD9GffLl9zYn1uFwSKz4hYH2fFeu2rgd+0cIrPxSrM=;
        b=DfWIhfWPc7ri9uXg22DeMtTzev6GOu6xvXIAvl3p6+h4NOSh3+uoVOukVq7mq9jGEv
         YWyAGKRv7skPxTOgj+PweHf7lQ4PZ1adezuNRXXlswI9ri//PgB6IuErUMwL8hSOzNyn
         rPzLqYAyO9qzmZiYqjvmY7Ick0RGfDbov3JVGzkUKL9lK0ziiZF9/zxMMkwkKlGIA4nA
         vuCh/0E0Ll6hjsQx6K2quXWWjX3CXwdQF2YmqglWEFo2N8WjYpd9RMTtuXKxZmIM/+tw
         XgjdrJ39Tw+sZEHpk5S1etZSz/I8P5XjPKmgYjDs+Jo2ZkzUjYn345IRU98sRZJ6pVky
         0Y9g==
X-Gm-Message-State: AOJu0YyGFVGoIo61vz4KTMipSzZlQyHpebLOoKEOXKdqVJ1gQyrIZAba
	bY8N008R860wGWOF9eso5dg=
X-Google-Smtp-Source: AGHT+IH70N/ZgYnf1fGYUAlmk7cwFwnNPNVphMBJpFPZBZsufvUjhDLWAQuX0YghHwU+z6fNxvNAPA==
X-Received: by 2002:a05:6870:d78a:b0:1b0:5141:4c6e with SMTP id bd10-20020a056870d78a00b001b051414c6emr14237313oab.26.1691470787508;
        Mon, 07 Aug 2023 21:59:47 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bp22-20020a056871281600b001bb919237cesm5751737oac.3.2023.08.07.21.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 21:59:46 -0700 (PDT)
Message-ID: <e0de1abc-ca37-62d9-92bf-6a460eb63d5e@gmail.com>
Date: Mon, 7 Aug 2023 23:59:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scan: remove unneeded debug prints
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230807191207.442919-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230807191207.442919-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/7/23 14:12, James Prestwood wrote:
> Removed several debug prints which are very verbose and provide
> little to no important information.
> 
> The get_scan_{done,callback} prints are pointless since all the
> parsed scan results are printed by station anyways.
> 
> Printing the BSS load is also not that useful since it doesn't
> include the BSSID. If anything the BSS load should be included
> when station prints out each individual BSS (along with frequency,
> rank, etc).
> 
> The advertisement protocol print was just just left in there by
> accident when debugging, and also provides basically no useful
> information.
> ---
>   src/scan.c | 8 --------
>   1 file changed, 8 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

