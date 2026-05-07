package com.evanemran.getx_news_clean_arch

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.net.Uri
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import android.widget.RemoteViews
import java.net.URLEncoder

/**
 * Implementation of App Widget functionality.
 */
class NewsWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs = HomeWidgetPlugin.getData(context) // SharedPreferences
        val json = prefs.getString("news_json", "[]") ?: "[]"

        val gson = Gson()
        val type = object : TypeToken<List<Map<String, String>>>() {}.type
        val list: List<Map<String, String>> = gson.fromJson(json, type)

        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.news_widget)

            val ids = listOf(R.id.title1, R.id.title2, R.id.title3, R.id.title4, R.id.title5)
            for (i in ids.indices) {
                val title = if (i < list.size) list[i]["title"] ?: "" else ""
                views.setTextViewText(ids[i], title)

                // make each headline open the app with the article url
                val url = if (i < list.size) list[i]["url"] ?: "" else ""
                if (url.isNotBlank()) {
                    val uri = Uri.parse("mynewsapp://article?url=${URLEncoder.encode(url, "UTF-8")}&homeWidget")
                    val pending = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, uri)
                    views.setOnClickPendingIntent(ids[i], pending)
                }
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}