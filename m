Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703E8F49
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU8wm048"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2b1af09c5so3619150b6e.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697728599; x=1698333399; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTBIRu5yC2fUrVT/9LbGjkXkwAQxK0enN1TNGrLUrnA=;
        b=VU8wm048nMHP3lrbV2bew1E7/HUxDNldbyHlQAavQNUU48xT8ms3lPoW9wnD3YknJA
         WaDwENzD3Twh7zy7pE5qr6bsE821uCr9yFet2PU4LUCCIsBSwnBVLuDGgjI+GWds5XQE
         7+uEcZGhVj+oS9Rvtmju2dODnMI+C6OTKlqH1Qc+slNmwsFJQ2Nc+ErviCjQ6G0haFHm
         5Q5eaxfCWtYGNdyKeA+dm5gjpeBwT60MHglYccjup5iMLPYBNX3WnzjkNeijprGxqS1d
         A8tmo/3E4vSR1DCeCdqOeWVeQv7yoYdSD+FxoETnSxriLYXyluhfC6VbqrdxDmpvy38Z
         Hv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728599; x=1698333399;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTBIRu5yC2fUrVT/9LbGjkXkwAQxK0enN1TNGrLUrnA=;
        b=ZWubhXubgNJckujnTiPrz2Nb8BgM6nLCtMlP0vLHs9gN+Nk5y+jtL/atn4rCIsWtZQ
         zA1/qRXrxsB/Gm9sgKc8N6MgnRBwGeGHFnTm4zT71rLoxWQHXJO5DLubeaOmv66vAE/K
         1qdwViiA2Y7a8wveDlxPIwICxoJiuxPt6EqRyqR29yhKkK1FpDtkep9/hodCtq9SwopH
         TBIlOqgvHsMCDBqT6Rff4WWCHixEslZhV+rPN/uYVjekBdgO/kOA5DnR8ARCMZ/kh+R+
         bMaQciITbPZ2LKEov+4Dnq4gE8ClqTj4gYNUOCRf3kuOKjBTGWUpSgk+SwRkenrKYyJU
         R4iA==
X-Gm-Message-State: AOJu0YxcFCga7ubPT4ukLvf1P1zm6baKXFY4+TIVJ8ZBY9r5f0vwL8BY
	B8Q/y514qwcggqpDvCfmLmv45+/atcA=
X-Google-Smtp-Source: AGHT+IHtEsL5Yqrd1TmzA6lc6QPGM3duy6pg/+agvLtwNnCr539deAQIKhpNx0w191DHucq3GhPe4Q==
X-Received: by 2002:aca:130a:0:b0:3a4:6b13:b721 with SMTP id e10-20020aca130a000000b003a46b13b721mr2351086oii.46.1697728599630;
        Thu, 19 Oct 2023 08:16:39 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s21-20020a05680810d500b003ae5cb55513sm1091174ois.38.2023.10.19.08.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:16:39 -0700 (PDT)
Message-ID: <0b431079-40f8-4aa1-a82d-01c9a5bfbe5f@gmail.com>
Date: Thu, 19 Oct 2023 10:16:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] dpp-util: add __DPP_STATUS_MAX
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-14-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-14-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> Nice for setting as an invalid status since STATUS_OK is
> already zero.

But this enum comes directly from the spec?

> ---
>   src/dpp-util.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/dpp-util.h b/src/dpp-util.h
> index 6b00796e..61f1c859 100644
> --- a/src/dpp-util.h
> +++ b/src/dpp-util.h
> @@ -71,6 +71,7 @@ enum dpp_status {
>   	DPP_STATUS_CSR_NEEDED,
>   	DPP_STATUS_CSR_BAD,
>   	DPP_STATUS_NEW_KEY_NEEDED,
> +	__DPP_STATUS_MAX,

In general iwd/ell do not use such constructs since it makes handling of enums 
in switch/case statements a bit more painful.

>   };
>   
>   enum dpp_attribute_type {

Regards,
-Denis
