Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD764A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:37 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id j12so15373543oij.3
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668876; x=1684260876;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wvy0RwydgmkCCZodYyG8463VhSaDdxa4Kay/TL/uyk=;
        b=oy+NLlNzsYrccDK6sJxH4DTK0IQvvsAIe4bAn2IOuaDT5rn5Zq94SiMBJ1myGWfTWA
         ZrWuPtme4xLlqR8FXXOG9t/4Lg65hUbxDUgDc/1xPgCmH5il33TvJggHBEq+Jg4R6Ek8
         r13cpmbSxz0+EoMBIb57CKOeWxkdOPjj6f+PTizg450xkvQHbARO3w1llCzcigrud6Nh
         WsaxPj4mg2dDaBtVDeYC60fXYWJSdLhW5IiuD/HE21NJJSW+Pfi2swvyuDNlp0GTVftI
         dnouyFD49qiyDeUPbyYXimkvApuISl5cAvVCv+9sLWVTMZ5XDC/v1mZdnedkijlkDZmK
         +9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668876; x=1684260876;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wvy0RwydgmkCCZodYyG8463VhSaDdxa4Kay/TL/uyk=;
        b=RrTTKnWR7Z3Ym+hU0byb5BrcfgRGeM4b3VhIh7+zu24UVfoqZStpxNmDgISJMOuFz0
         pzz9WoWIRI5iZH42xzQP8wOSkoi3/4rdfgXPmGRX+/ApHMTO0aFevwVYBNvjivVmJCca
         B2cKBFYaUa/tGXbHl2fQtiaJ8OgMaesCXg39EQ+lKNr7/u9NMi4qIbz5dEv7iKdAujSf
         Hb3Hhf9DXLdiuNvHDR82j3bF3VdGOJ2yA37/jE/j7bWF+yKdFcvnnBea+Tb5z+7M3WWj
         DhzZUIowTc203dvCeAzM7FNZgS16tgniBlc2wPxfz4Ig5AIyD14YWvAAGy4iUqWKe5jh
         4xaw==
X-Gm-Message-State: AAQBX9eEISd45tD64rPTG4IQTM8YvjXQl64fKD8b4xZ/5+pTVjsJQx0V
	klRZ3ZhaB+bHdqhEsJLzFX4=
X-Google-Smtp-Source: AKy350afcGe7HCvIs1tRiptJ7gtVmut0gtwggkyFTtxDU9lL/Tlkp9I1uC7dWJbYAf0JU6FBxgAjdg==
X-Received: by 2002:a05:6808:9:b0:387:2833:619f with SMTP id u9-20020a056808000900b003872833619fmr5442883oic.15.1681668876554;
        Sun, 16 Apr 2023 11:14:36 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s16-20020a056808009000b0038ded2e4f05sm803820oic.16.2023.04.16.11.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:34 -0700 (PDT)
Message-ID: <d56ed534-e6be-229f-d7b9-2938f3c7605a@gmail.com>
Date: Sun, 16 Apr 2023 11:30:30 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwsim: properly cleanup rules queue
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230410171232.32739-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230410171232.32739-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/10/23 12:12, James Prestwood wrote:
> After adding prefix matching the rule structure contained allocated
> memory which was not being cleaned up on exit if rules still
> remained in the list (removing the rule via DBus was done correctly)
> ---
>   tools/hwsim.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
