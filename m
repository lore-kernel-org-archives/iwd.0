Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6F7C
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 03:04:22 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1b730eb017bso193183fac.1
        for <iwd@lists.linux.dev>; Wed, 12 Jul 2023 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217461; x=1691809461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/2fHI9tcfN7OVleG/JUiQMbn+qD2bfMCmut+CtYlX0=;
        b=Ze2x9CttQheSbntU1WYb9iE217MW2n3qVB5rRAG+8ZhWpwuu1W4Puq0iEC5dFIDq0i
         2SzXMpZCYL+KJP1eBPOhW+1KYvNtMNNExFJicZJTmidYbD8xRtCUIzItQaIguDkC8RXw
         2KgFiJE7XnsrlXKrYYv7qNJhDP7FNRIghl/xOgNoBWVv9sa3rX8d4jFBMUQKjz9sZ6Nm
         7YBD/AY6YdY2n5S6D0kk3ix4CfpwMf2Z75M4+AHyt4deEboT9JpnzEyCxVpHA6fCM1cw
         lmZaw7vPFNaBUiAfKxHVcduGRqdnjEk8TXezVBdXb/L2e92zBG/Hw0XrgBjVLGU8Tn/H
         ztPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217461; x=1691809461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/2fHI9tcfN7OVleG/JUiQMbn+qD2bfMCmut+CtYlX0=;
        b=GQ+Z3U7kKfx4rsiSP3K9j+OHsgbYv3aEdNdxTH7OckaTzvny/bLqXfghiZ+K5TfWs5
         KcJXJ0rfJ0fIo7S4i7+52NbJ9+rNB8IdGmQ0wsDHxDhjbGgX/ISN1c7ch0Ix13V+/Ryc
         gEDqAzjVpJ3jK6r3NkfKM+b6OSptEeKbsps2G6nl2DGux24VPnz2CCsgHMCUQg58D7yr
         ZRWF8tEnHv2uxDHIbtHXjBbBAcoO6zcxFnAz40Vw/AfLJs9MicpjP7fDniCzhJMzvlif
         BSs9/+yj3fBKVmDAuqlnR3pc59k2JUUmoF0zZZMtEdrtECIJiXV97/yZH8yJjC0ZU7Vh
         5TGA==
X-Gm-Message-State: ABy/qLZMNhCJxlevAU6yEVq8r107LcHQCR1yD+eMU428EQxVC1P2Czq7
	D3BOmBfNDfbijiP88Ef5XHM=
X-Google-Smtp-Source: APBJJlHxtO7tUHSQ7fw+88B4qO5cIMrx7jYGY8iNzLihjTOEWgAZzx5EnqRM/Da/L7wTjt4nFqgkHw==
X-Received: by 2002:a05:6870:b685:b0:1b7:330f:ae75 with SMTP id cy5-20020a056870b68500b001b7330fae75mr621498oab.35.1689217461071;
        Wed, 12 Jul 2023 20:04:21 -0700 (PDT)
Received: from [192.168.254.37] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001b8a53dde99sm4640076pln.296.2023.07.12.20.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:04:20 -0700 (PDT)
Message-ID: <0617fffe-2f26-bceb-5bd9-782882f24dd0@gmail.com>
Date: Wed, 12 Jul 2023 20:04:20 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: Wen Gong <quic_wgong@quicinc.com>, iwd@lists.01.org, iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
 <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
 <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
 <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
 <03b87aea-9d3b-78b5-e187-94c4310982cb@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <03b87aea-9d3b-78b5-e187-94c4310982cb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wen,

> 
> ======================Association Response start======================
> 
> copied from wireshark:
> 
> Frame 2354: 274 bytes on wire (2192 bits), 274 bytes captured (2192 
> bits) on interface 0
> Radiotap Header v0, Length 48
> 802.11 radio information
>      PHY type: 802.11a (5)
>      Turbo type: Non-turbo (0)
>      Data rate: 6.0 Mb/s
>      Frequency: 6295MHz
>      Signal strength (dBm): -45dBm
>      Noise level (dBm): 0dBm
>      Signal/noise ratio (dB): -45dB
>      TSF timestamp: 587853891749
>      [Duration: 328µs]
> IEEE 802.11 Association Response, Flags: ........
>      Type/Subtype: Association Response (0x0001)
>      Frame Control Field: 0x1000
>      .000 0000 0011 1100 = Duration: 60 microseconds
>      Receiver address: 64:c4:03:88:ff:26
>      Destination address: 64:c4:03:88:ff:26
>      Transmitter address: fc:34:97:2b:1b:48
>      Source address: fc:34:97:2b:1b:48
>      BSS Id: fc:34:97:2b:1b:48
>      .... .... .... 0000 = Fragment number: 0
>      0001 1100 1000 .... = Sequence number: 456
> IEEE 802.11 wireless LAN
>      Fixed parameters (6 bytes)
>      Tagged parameters (196 bytes)
>          Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, 
> [Mbit/sec]
>          Tag: RM Enabled Capabilities (5 octets)
>          Tag: Extended Capabilities (11 octets)
>          Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
>          Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
>          Ext Tag: MU EDCA Parameter Set
>          Ext Tag: HE 6GHz Band Capabilities
>          Ext Tag: OWE Diffie-Hellman Parameter
>              Tag Number: Element ID Extension (255)
>              Ext Tag length: 51
>              Ext Tag Number: OWE Diffie-Hellman Parameter (32)
>              Group: 384-bit random ECP group (20)
>              Public Key: 14ba9d8abeb2ecd5d95e6c12491b16489d1bcc303e7a7fbd…
>          Tag: Vendor Specific: Broadcom
>          Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element

Indeed, it doesn't include the RSNE as it should. Out of curiosity do 
you know what AP model/manufacturer this is? Its nice to document this 
for others and to reference in the future.

Thanks for digging into this. If Denis is fine with relaxing the check 
I'll send a patch and take care of that.

Thanks,
James

> 
> hex byte copied from air sniffer wireshark
> 
> IEEE 802.11 Association Response, Flags: ........
> 0000   10 00 3c 00 64 c4 03 88 ff 26 fc 34 97 2b 1b 48 ..<.d....&.4.+.H
> 0010   fc 34 97 2b 1b 48 80 1c                           .4.+.H..
> 
> IEEE 802.11 wireless LAN
> 0000   11 10 00 00 0b c0 01 08 8c 12 98 24 b0 48 60 6c ...........$.H`l
> 0010   46 05 30 00 00 00 00 7f 0b 04 00 48 80 01 00 00 F.0........H....
> 0020   c0 01 00 01 ff 27 23 01 00 08 12 00 10 4c 20 02 .....'#......L .
> 0030   c0 6d 5b 81 18 00 8c 00 aa ff aa ff aa ff aa ff .m[.............
> 0040   7b 1c c7 71 1c c7 71 1c c7 71 1c c7 71 ff 0c 24 {..q..q..q..q..$
> 0050   04 00 03 16 fc ff 45 03 47 4f 00 ff 0e 26 08 00 ......E.GO...&..
> 0060   a4 08 20 a4 08 40 43 08 60 32 08 ff 03 3b 7d 06   .. ..@C.`2...;}.
> 0070   ff 33 20 14 00 14 ba 9d 8a be b2 ec d5 d9 5e 6c   .3 ...........^l
> 0080   12 49 1b 16 48 9d 1b cc 30 3e 7a 7f bd 13 28 7b .I..H...0>z...({
> 0090   0c 84 e5 05 64 48 c1 ac 1e 78 38 db 33 7a 1e 5f ....dH...x8.3z._
> 00a0   71 9f 6f 11 b8 dd 09 00 10 18 02 00 00 9c 00 00 q.o.............
> 00b0   dd 18 00 50 f2 02 01 01 88 00 03 a4 00 00 27 a4 ...P..........'.
> 00c0   00 00 42 43 5e 00 62 32 2f 00 ..BC^.b2/.
> ======================Association Response end======================
> 
>>
>> $ sudo iwmon --nortnl --nowiphy --noscan
>>
> I think above hexdump is readable/enough, if it is not, I will use iwmon 
> to collect again.
>> Denis,
>>
>> Is relaxing the RSNE check in the associate response (for OWE only) 
>> something you'd be ok with? Obviously with an L_WARN_ON/l_warn message.
>>
>> Thanks,
>> James
