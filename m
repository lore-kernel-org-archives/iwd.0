Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A121113
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 04:40:42 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id p132so9618019oif.9
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 21:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/FzhB1tPeiyWHH1bz1Jjym5JBI9BcfUsc+BmYah7GpE=;
        b=nWiUd4YxKPCV1pcFrv1IMUIEMsix8hLB60KDSbOzZuVJbyRqm81bZ4TVUBBzvjZu1v
         r4kKU1GbthKf84angllX7DGvwx8N+SwB/txWes5wShpD/OuZgAQwEK/WxBverMlQgpw3
         M5ADKRHzK/LNeUvTcuaCt/XLJccgtcGCCW/gf6Da3CK9HLyd6pzaL9SU8YAVR92KW2kV
         1WlEeW0xCrAWMTrnOGAyjW5edJoaJDR0+r3jsEpS44oTSK9NnhnEW4pTOK6Xv9GcI6EY
         i7t+SMRyF873TUb2+ECbmv2CX6MxiXrsFg9sIQ/bFEqOZcC14W/MmvHayoJK0oKEa7U2
         fv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/FzhB1tPeiyWHH1bz1Jjym5JBI9BcfUsc+BmYah7GpE=;
        b=6Zq2TkdzOPyJSRLX+sn8uH1cbcVmuMv63rBDFTCfQ25kmvKR/n5zL6TaZH08GBmZEl
         QI2G4tyz4yQmVFJBL5wMKMSnH26pkwagXpoLvb5tLP76dewfTpKvQsaIciu3nqT8dvhR
         Aopd4Na3ye2gimg9FbbOu446FJ9aw+hh8l/mgFVvH+83ruizmQqU/ItxclkxbLDUkk8m
         SYMDbXgVibwSBs9jWLfs1RJS/SPwayq2UR6TcrI3gxHA7bQ+pwBBerdYY+hjHZB7jJ5q
         DtnUyv1Wc2unP9DScHr4jikgQ9OYa3edDFlLRZqF0BnyYYf09uaSn0foIO61tVbCLiYV
         nsAg==
X-Gm-Message-State: AJIora/CxTnSMqOlCiPjwCaKTWP8ndYadJhJtDRHVMnDN8pPCiXjAIJX
	fkkBaz9WGqcAmQX2HO7d0Cc=
X-Google-Smtp-Source: AGRyM1vp8V1thKM8TuVXcknyVLodvY3znwnEG6xHYRfeMYjmj/xdzU2P48siEEWXXsznJGn3GdCfYQ==
X-Received: by 2002:a54:438c:0:b0:32f:45e3:243c with SMTP id u12-20020a54438c000000b0032f45e3243cmr1519862oiv.74.1658292041316;
        Tue, 19 Jul 2022 21:40:41 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id eo36-20020a056870eca400b00101f9e87b39sm8578748oab.11.2022.07.19.21.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 21:40:40 -0700 (PDT)
Message-ID: <e74694b1-f62c-f430-6c2f-32d275c61763@gmail.com>
Date: Tue, 19 Jul 2022 23:23:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd fails to connect when passphrase > 40 characters on 5Ghz;
 times out on 2.4Ghz
Content-Language: en-US
To: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <E34D86E6-F357-4233-A698-C0EAC029F431@kvh.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <E34D86E6-F357-4233-A698-C0EAC029F431@kvh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> On 5Ghz, iwd fails to connect with kernel message "wlan0: deauthenticated from <mac omitted> (Reason: 2=PREV_AUTH_NOT_VALID)" when the passphrase is 41 characters or longer. 40 characters or less works fine. Curiously, my Mac OS client has no problem connecting to the same access point with passphrases up to the full 63 characters allowed.

I doubt the passphrase length has anything to do with this.  As a sanity check I 
just ran a 46 character passphrase through a few auto-tests and it works fine. 
The 5G log does seem to imply that the AP doesn't like our reply in message 2/4, 
likely due to a passphrase mismatch.

How are you entering it? iwctl? Editing the .psk file manually? or ?

> 
> On 2.4Ghz, iwd fails to connect with kernel message "wlan0: authentication with <mac omitted> timed out" (after 3 tries), regardless of the password length.

This is even more suspicious.  We can't even associate successfully, so the 
passphrase isn't even entering into equation.

I would try:
   - Stop iwd and rm -rf /var/lib/iwd/<yourssid>.psk
   - Reboot the router

and try again.

Regards,
-Denis
