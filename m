Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298D20E8
	for <iwd@lists.linux.dev>; Fri, 14 Jul 2023 14:12:21 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-392116ae103so1492935b6e.0
        for <iwd@lists.linux.dev>; Fri, 14 Jul 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343940; x=1691935940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwA4AS4E1FPvo83eycHAX9/pZ+K/1x1lzX5KKqrF0QE=;
        b=FoBzy/to/+CuSmA/N49MkPEUnzAwLXy/8e4i++YLqyO4CnvDqxoWhcH+PH305s3lTc
         gO8DNSlrwQJ5nKdp/Alovc8JuTETpCzHeLgPf+nZNDvi8lvdBjoBV2tpDOsHmGuQFDim
         0I0vwOxDudeWi2pmgLI1g1ol9FQqXmehr4vcPmilTmd/O+8KCeWsBguP9tW3SjYux/H4
         Jc7aV+CZo/mohqKawuSJMiV58bECMAwksGGu3qhuiUo+OWluT/RiZjyscrx7zlPiCmhR
         o0r/tP0GlCRllY1+DfPDm5TA9HwjbskS+ccG6mA1gCURRdiVKLGAhwmFopLwxpYFh5Sq
         LfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343940; x=1691935940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwA4AS4E1FPvo83eycHAX9/pZ+K/1x1lzX5KKqrF0QE=;
        b=beYmkrKv0VO25rWZoKwphzzSmUUTDpKOYoq8gF7kk+U7/5HIEbbS2i99Qs/Oyy/nbs
         dTPrzEvJiP3DchPwRIV3uGEPvVWiGtobGbTfA/e0UtZ9ed0WEHFmbAHePCGMcTh829UA
         f+R6Xc70Cab+hViRgVKlGPu3wqkMCObE4OoKxTQ0Edqly5i66lTX3Km7upL7hH17tx7O
         ekXb/TPkjohFX/WQe31GWVbNmr35I3DYEsahSPfc+0by9o5lICvwmB1HQu10FBJsveOs
         a8R3MT6DnAtR347RoHJ1OqhLAZ6JOxcvgJjf+efbJOUK2X6NQFOjJc9aTp85qPtItYgI
         YfcA==
X-Gm-Message-State: ABy/qLbNcG/3XjnfCUDLpdL4flR1wYxOlFfOVoFthHJUU+Cdzrb0lxQu
	t6zVqOXZrE0ZnpvC6zIAO9siMwoM1Lk=
X-Google-Smtp-Source: APBJJlGC5YEuM9Q3H8jYLeko2dX49lH//6E9c6L2gEQ4n66YCjgC2/7JY970CnaKNB4dJk2oEZ/uRg==
X-Received: by 2002:a54:4f02:0:b0:3a3:7612:28c7 with SMTP id e2-20020a544f02000000b003a3761228c7mr5236465oiy.23.1689343940220;
        Fri, 14 Jul 2023 07:12:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bl30-20020a056808309e00b003a37fd2be45sm3901018oib.31.2023.07.14.07.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:12:19 -0700 (PDT)
Message-ID: <a4215f73-0f58-5c3f-5022-6871ea3b0af1@gmail.com>
Date: Fri, 14 Jul 2023 09:10:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] netdev: relax requirement for OWE AKM in assoc reply
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Wen Gong <quic_wgong@quicinc.com>
References: <20230713144237.2977210-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230713144237.2977210-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 7/13/23 09:42, James Prestwood wrote:
> Some APs don't include the RSNE in the associate reply during
> the OWE exchange. This causes IWD to be incompatible since it has
> a hard requirement on the AKM being included.
> 
> This relaxes the requirement for the AKM and instead warns if it
> is not included.
> 
> Below is an example of an association reply without the RSN element
> 
> IEEE 802.11 Association Response, Flags: ........
>       Type/Subtype: Association Response (0x0001)
>       Frame Control Field: 0x1000
>       .000 0000 0011 1100 = Duration: 60 microseconds
>       Receiver address: 64:c4:03:88:ff:26
>       Destination address: 64:c4:03:88:ff:26
>       Transmitter address: fc:34:97:2b:1b:48
>       Source address: fc:34:97:2b:1b:48
>       BSS Id: fc:34:97:2b:1b:48
>       .... .... .... 0000 = Fragment number: 0
>       0001 1100 1000 .... = Sequence number: 456
> IEEE 802.11 wireless LAN
>       Fixed parameters (6 bytes)
>       Tagged parameters (196 bytes)
>           Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
>           Tag: RM Enabled Capabilities (5 octets)
>           Tag: Extended Capabilities (11 octets)
>           Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
>           Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
>           Ext Tag: MU EDCA Parameter Set
>           Ext Tag: HE 6GHz Band Capabilities
>           Ext Tag: OWE Diffie-Hellman Parameter
>               Tag Number: Element ID Extension (255)
>               Ext Tag length: 51
>               Ext Tag Number: OWE Diffie-Hellman Parameter (32)
>               Group: 384-bit random ECP group (20)
>               Public Key: 14ba9d8abeb2ecd5d95e6c12491b16489d1bcc303e7a7fbd…
>           Tag: Vendor Specific: Broadcom
>           Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
> 
> Reported-By: Wen Gong <quic_wgong@quicinc.com>
> ---
>   src/netdev.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

