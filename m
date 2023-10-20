Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B112E65
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3RonJce"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d11fec9a5so4860256d6.1
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697806339; x=1698411139; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dnm4GM4OE7bd05TuSAU/Sbv4DI+nqzwohLuN00aFvgg=;
        b=c3RonJceZbJsjEmxnCGLKXLdJokMJgTsJ+ngAfUS0XNtqH1PpOK+vhKuEX8dQcLNlh
         WH2LsqtWReJdupDBemiowHj09IS5aNVclXfnywXGA54k+lDgxnVEw6k/QDW7AuU1vkOY
         IUsYmxvloxVFFiZIxlKPDJfx2GCUQrO4q85QSYiY9WadLBUtYzKNMEjeNotXv29MtTpl
         1KRKvGI4xhL7yezivOgpX/Pd/OOVr1QTr5bn3rSs3wnKwfTZ5AA+YVy2h1wbYXn8Eede
         aSQF/Z0YYG7kt3yY6CRxxdr0bq4fdrGOv0YWhRYgFF/lfF5PUjM7ooKehFtxMLXu8/ce
         pYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806339; x=1698411139;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnm4GM4OE7bd05TuSAU/Sbv4DI+nqzwohLuN00aFvgg=;
        b=HB+6xACCabu8iFMmg28EPEJLpsfN0TaHHucPesNy4PXTvrQcfY62U47meyc5e+5PYl
         H5fIetdli+adadpeouF3nC0b2vwMFBvKc25gZiQ4P1EVf7Sy6g19ODzAs9a8DOOHTHMZ
         cEXB/pNU3rJW7Q9095jqp20mxhps3ouXJG2/4Io/AzIjz3hUbCIJAKpbbAeUl/WbOfXD
         WVYzFhAEOZhphp7wjNVCbmhmEm7ZaNKKGs3rT3IeOOyXGW3JpTIMoDQ1Yshmi+33XkqE
         ryOhkJf3oRf4Ov48i1vU9pbyBEQJMjdT5iKgiQld8xz8+YjPX9zMg8i2KPw1JVAT72bN
         1Xhg==
X-Gm-Message-State: AOJu0YznC/uyZ2dGIGK1DZg4SW/fYZnp5znWiV904PqFZKVwFYL27hsd
	bN2jgWSn8RO5CMdpI/jUvgqi9VQ2K9o=
X-Google-Smtp-Source: AGHT+IFbefJ9s133BQd6oQyhJjT0DvtIQasphN7fh1nSEBTeMCyDl9HY8UHWSS5eqyHFtfHPIg1Row==
X-Received: by 2002:a0c:b458:0:b0:66d:3716:4e14 with SMTP id e24-20020a0cb458000000b0066d37164e14mr1646261qvf.4.1697806339126;
        Fri, 20 Oct 2023 05:52:19 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dk9-20020a056214092900b0065b5306565esm648847qvb.112.2023.10.20.05.52.18
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 05:52:18 -0700 (PDT)
Message-ID: <a8885dd9-eeff-4318-b7c9-5f54a3273913@gmail.com>
Date: Fri, 20 Oct 2023 05:52:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: install iwd-decrypt-profile
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231003192456.4038590-1-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231003192456.4038590-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Resending in case this got missed.

On 10/3/23 12:24 PM, James Prestwood wrote:
> If profile encryption is enabled its not out of the question that
> somebody might need to decrypt it. This isn't a problem building
> from source but IWD as a package likely won't include the decrypt
> tool unless its specifically copied out. Add iwd-decrypt-profile
> to the list of installed programs like iwctl, iwmon, etc
> 
> This also fixes a minor bug in Makefile.am which was building both
> iwd-profile-decrypt and probe-req if DAEMON was true. This should
> be TOOLS.
> ---
>   Makefile.am | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 2e962153..ebabcf1c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -378,8 +378,9 @@ man_MANS += wired/ead.8
>   endif
>   endif
>   
> -if DAEMON
> -noinst_PROGRAMS += tools/probe-req tools/iwd-decrypt-profile
> +if TOOLS
> +noinst_PROGRAMS += tools/probe-req
> +bin_PROGRAMS += tools/iwd-decrypt-profile
>   
>   tools_probe_req_SOURCES = tools/probe-req.c src/mpdu.h src/mpdu.c \
>   					src/ie.h src/ie.c \
