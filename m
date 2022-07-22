Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756B4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 18:19:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id b9so5100953pfp.10
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=oaQJQTQbO5ZKlIBGheC2Qy1RCC+zOuBrKGw5yA7FdRs=;
        b=nko/AcWFR8w3Y5KZ0CQ0labmMNghrbNSJKcSzsHK2tJaKo37pH6O21nTEsF25+QKmH
         K95umCL58TB+5myu6NoKgxefwQi0YlIUO56CxjuCnOQGhs6C+7Dimg2iRPQd3D8uXqiQ
         6ME9eVxaCPiILszm37o9elPHw46dydC55/odYfkRsNrx1UY9fgiSKK6HHwwWiAOkJMjq
         NxiaQSq5LdwRSI5F93KjgeQoJ4rVFtl2m2wrMnru9JwJrbWKWGuktt5CdxT7t1Iygoet
         8DPxOIuwFQS9ZTGan5AEmAwer+RWnm7pk2d9LII0C1kVR+seTOUO6tP7kgqIFQKA7HCk
         uj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oaQJQTQbO5ZKlIBGheC2Qy1RCC+zOuBrKGw5yA7FdRs=;
        b=c/B92NFprKHHj7lKG1riCm4OSwJnzWEO1oGYrTu3wARXsXttpC/lMFlPXd1Q6PQnqq
         rDvAltT4SzTw7hkhbLX8WhUdlSicB6lAsWQ904NDR1WFcFxvbbAbOna2eVHlIJN+4418
         YZ25MVt/NzAM6HUsn37O9XhVoPprNxJtPaSxrbVwqdoHjynYxBpybtZJsHSKX7Gh/Rc8
         +xlom2lPuHYiGdWOFn3XVtDeghcYn/+Mud9H2jeRz/xVYFAfkaxTs5Z9rwLoq0zKpyIv
         CBkhRxC/oCwzb3iY/I1pSa+0y2KC55vi89SQ6MlJqE6wMb3ry8RQpJGGTqWeF0ryADtk
         s+Yw==
X-Gm-Message-State: AJIora/YXreJoSrYb8Q79s0c7TnsXSKcYwy2TqDlfPd5LXxfuRfxlnbu
	NKIinIDJytY6TtvYKbkVa5o=
X-Google-Smtp-Source: AGRyM1vECGxbBpI/MgSjVMFEK0UOWN+bjUiOA54umnqFgKskCSad3+9Yh0nqCWLS2/4oxJUoQGCYSw==
X-Received: by 2002:a05:6a00:134c:b0:52a:c52f:b339 with SMTP id k12-20020a056a00134c00b0052ac52fb339mr1221323pfu.32.1658513941811;
        Fri, 22 Jul 2022 11:19:01 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0016bdc98730bsm4099419plg.151.2022.07.22.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:19:01 -0700 (PDT)
Message-ID: <cef5bf6d59f8c480ed948edbc6bb45b098d1ee84.camel@gmail.com>
Subject: Re: [PATCH 5/7] manager: re-dump wiphy on regulatory change
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 22 Jul 2022 11:18:56 -0700
In-Reply-To: <692012c2-ff3f-185a-47de-f09d99311296@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
	 <20220722163417.1119334-5-prestwoj@gmail.com>
	 <692012c2-ff3f-185a-47de-f09d99311296@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2022-07-22 at 12:38 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 7/22/22 11:34, James Prestwood wrote:
> > This is required due to the kernel not waiting for regulatory
> > updates before
> > sending the wiphy dump. The initial dump usually contains all
> > supported
> > frequencies, none of which are disabled. Later, the regulatory
> > subsystem
> > populates the frequency list which can significantly limit allowed
> > frequencies.
> > 
> > Even disregarding this problem, any regulatory update will modify
> > the allowed
> > frequencies so re-dumping wiphy should still be done on a
> > regulatory change.
> 
> git likes it if the description lines are limited to 72 columns.
> 
> > ---
> >   src/manager.c | 58 ++++++++++++++++++++++++++++++++++++++++++----
> > -----
> >   1 file changed, 48 insertions(+), 10 deletions(-)
> > 
> > diff --git a/src/manager.c b/src/manager.c
> > index ca29e110..c8d56a99 100644
> > --- a/src/manager.c
> > +++ b/src/manager.c
> > @@ -666,6 +666,29 @@ static int
> > manager_wiphy_filtered_dump(uint32_t wiphy_id,
> >         return 0;
> >   }
> >   
> > +static unsigned int manager_dump_wiphy(uint32_t wiphy_id)
> > +{
> > +       struct l_genl_msg *msg;
> > +       unsigned int wiphy_dump;
> > +
> > +       msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
> > +
> > +       if (wiphy_id)
> 
> Do note that phys start numbering at 0.  So this is probably not
> going to work.

Whoops, I thought zero was reserved. I'll use -1 instead.

> 
> > +               l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4,
> > &wiphy_id);
> > +
> > +       l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP,
> > 0, NULL);
> > +       wiphy_dump = l_genl_family_dump(nl80211, msg,
> > +                                               manager_wiphy_dump_
> > callback,
> 
> Are the parsers really setup to free-and-re-parse the wiphy dump
> information? 
> Perhaps using a callback that would parse only a subset of the
> information would 
> be better?

I thought they were since the wiphy dump comes as tons of separate
messages. Once the wiphy object is created we just keep adding stuff to
it. But maybe I overlooked this.

> 
> > +                                               NULL,
> > +                                               manager_wiphy_dump_
> > done);
> > +       if (!wiphy_dump) {
> > +               l_error("Wiphy information dump failed");
> > +               l_genl_msg_unref(msg);
> > +       }
> > +
> > +       return wiphy_dump;
> > +}
> > +
> >   static void manager_config_notify(struct l_genl_msg *msg, void
> > *user_data)
> >   {
> >         uint8_t cmd;
> 
> Regards,
> -Denis


